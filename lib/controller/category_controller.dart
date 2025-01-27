import 'dart:math';
import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fideos_web/common/common_image_picker.dart';
import 'package:fideos_web/common/common_image_uploader.dart';
import 'package:fideos_web/model/categories.dart';
import 'package:fideos_web/presentation/categories/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
// instance of categories
  CollectionReference categoryTable =
      FirebaseFirestore.instance.collection('categories');

  // category titles
  List<String> categoryTitles = [
    "Category Id",
    "Doc Id",
    "Enabled",
    "Category Name",
    "Category Details",
    "Category Image",
  ];

  /* categories loading */
  RxBool categoriesLoading = false.obs;
  RxBool categoriesLoadingforUpdate = false.obs;

  /* category enabled */
  RxBool categoryEnabled = false.obs;

  /* category data for ui table view*/
  RxList<List<String>> categories = <List<String>>[].obs;

  /* category data - category model format for  */
  RxList<Category> categoriesParsed = <Category>[].obs;

  /*______________________________UpDate category_____________________________  */
  TextEditingController categoryNameController = TextEditingController();

// selected category
  Rx<Category> selectedCategory = Category().obs;
  RxBool categoryLoading = true.obs;
  // ___________________________________________________________________

  /* controller for adding category name */
  TextEditingController categoryName = TextEditingController();
  TextEditingController categoryDetails = TextEditingController();

  /* selected image */
  Rx<Uint8List> selectedImage = Uint8List(0).obs;

  /* uploading category details */
  RxBool uploadingCategory = false.obs;

// fetching categories from firebase DB
  void get fetchCategories async {
    // category loader
    categoriesLoading.value = true;

    try {
      // fetching category table data from firestore database - return data type is querysnapshot */
      QuerySnapshot querySnapshot = await categoryTable.get();

      /* list of all the documents included in this snapshot */
      final documents = querySnapshot.docs;

      categoriesParsed.clear();
      categories.clear();

      /* looping through documents and getting the actual data */
      for (var doc in documents) {
        /* every data from table in raw json format */
        final rawData = doc.data() as Map<String, dynamic>;

        /* parsing rawdata into the category */
        final category = Category.fromJson(rawData);
        /* customer doc id */
        category.docId = doc.id;
        /* adding into the category parsed list */
        categoriesParsed.add(category);

        /* adding into the category list for viewing table data */
        categories.add(
          [
            category.id.toString(),
            category.docId.toString(),
            category.enable.toString(),
            category.name.toString(),
            category.details.toString(),
            category.image.toString()
          ],
        );

        /* refreshing both the ui list and product list */
        categories.refresh();
        categoriesParsed.refresh();
      }
    } catch (e) {
      dev.log(e.toString());
    }
    /* category loading ended */
    categoriesLoading(false);
  }

// update category
  void get updateCategory async {
    categoriesLoadingforUpdate(true);

    final categoryId = selectedCategory.value.docId;

    /* update Category */
    final category = {
      "name": categoryNameController.text.toString(),
      "enable": categoryEnabled.value
    };

    try {
      await categoryTable.doc(categoryId).update(category);

      /* refreshing category table & going back */
      fetchCategories;
      categories.refresh();
      categoriesParsed.refresh();
      Get.back();
    } catch (e) {
      /* logging error */
      dev.log(e.toString());
    }
    /* adding category -button loading */
    categoriesLoadingforUpdate(false);
  }

  /* pick image */
  void get pickImage async {
    final temp = await CommonImagePicker.pick;
    if (temp.isNotEmpty) {
      // storing the unit8list if image is picked
      selectedImage.value = temp;
    }
  }

  /* checking image & upload category */
  void get upload {
    /* starting upload */
    uploadingCategory(true);

    /* checking if selected image is empty or not */
    if (selectedImage.value.isEmpty) {
      /* when no image is selected for category */
      uploadCategory();
    } else {
      /* when image is selected */

      uploadImage;
    }
  }

  /* upload category when image is not available */
  void uploadCategory({String? url}) async {
    /* preparing a random category id */
    final randomCategoryId = "Category-${Random().nextInt(1000)}";

    /* enable parameter default will be true */
    const enable = true;

    /* category image url */
    final image = url ?? "";

    /* category name */
    final name = categoryName.text.trim();
    final details = categoryDetails.text.trim();

    /* category model */
    Category category = Category(
      /* a random id is created for category */
      id: randomCategoryId,
      enable: enable,
      image: image,
      name: name,
      details: details,
    );
    dev.log(category.toString());

    try {
      /* trying to upload the category details in the category table */
      /* adding category data */
      await categoryTable.add(category.toJson());

      /* logic - after uploading the category data to the server we have to refresh
      the data table in the previous screen - we can do this in two ways:
      1. Refetch the table data from server (call the fetch table data function)
      2. Manually add the data in the table data variable 
      
      Advantages: 
      1. For procedure 1, data will fetch every time a new data pushed into the table
      2. For procedure 2, there will be minimal load on the server to fetch data */

      /* using procedure 2 */
      /* preparing the category table data array */
      List<String> tempCategoryTableData = [
        randomCategoryId,
        enable.toString(),
        name,
        details,
        image,
      ];

      /* adding in category table data category ui table list*/
      categories.add(tempCategoryTableData);

      /* refreshing category list */
      categories.refresh();

      /* back to previous screen */
      Get.back();
    } catch (e) {
      /* when some error occurs */
      /* show flash message here */
      dev.log(e.toString());
    }

    /* ending upload */
    uploadingCategory(false);
  }

  /* upload image */
  void get uploadImage async {
    /* proceeding to upload image */
    try {
      // getting the downlaod url for update after uploading the image in firebase
      final downloadUrl = await UploadImageToFirebase.upload(
          data: selectedImage.value, folderName: "category");
      // s
      if (downloadUrl.isNotEmpty) {
        /* image uploaded successfully */
        uploadCategory(url: downloadUrl);
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
