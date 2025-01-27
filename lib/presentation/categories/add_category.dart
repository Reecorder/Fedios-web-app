import 'package:fideos_web/common/common_button.dart';
import 'package:fideos_web/common/common_textfield.dart';
import 'package:fideos_web/model/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/category_controller.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  final controller = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              // name
              categoryNameTextField,
              // details
              categoryDetailsTextField,
              const SizedBox(height: 15),
              // add iamge
              addImageButton,
              // view image
              imageWidget,
              // submit button
              submitButton
            ],
          ),
        ),
      ),
    );
  }

  /* submit button */
  Widget get submitButton => Obx(
        () {
          if (controller.uploadingCategory.value) {
            return Center(
                child: CircularProgressIndicator(color: AppColor.primary));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Align(
                  alignment: Alignment.center,
                  child: CommonButton(
                      title: "Submit",
                      onPressed: () {
                        controller.upload;
                      })),
            );
          }
        },
      );

  /* image widget */
  Widget get imageWidget => Obx(() {
        if (controller.selectedImage.value.isEmpty) {
          return const SizedBox();
        } else {
          return Image(
              height: 400,
              width: 400,
              image: MemoryImage(controller.selectedImage.value));
        }
      });

  /* add image button */
  Widget get addImageButton => Align(
      alignment: Alignment.center,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: () {
            controller.pickImage;
          },
          child: const Text("Select Image",
              style: TextStyle(color: Colors.black))));

  /* app bar */
  PreferredSize get appBar => PreferredSize(
      preferredSize: const Size(double.infinity, 50), child: appBarWidget);

  /* appbar */
  AppBar get appBarWidget => AppBar(
      title: appbarTitle,
      centerTitle: false,
      backgroundColor: AppColor.primary);

  /* appbar title */
  Widget get appbarTitle => const Text("Fideos Admin Panel - Add Categories",
      style: TextStyle(color: Colors.white, fontSize: 17));

  /* category name text field */
  Widget get categoryNameTextField => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CommonTextField(
            controller: controller.categoryName, hint: "Category Name"),
      );

  /* category details text field */
  Widget get categoryDetailsTextField => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CommonTextField(
            controller: controller.categoryDetails, hint: "Category Details"),
      );
}
