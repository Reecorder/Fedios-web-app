import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/common_flash_msg.dart';

class FoodController extends GetxController {
// loader
  RxBool foodLoading = false.obs;

  // food titles
  List<String> foodTitles = [
    "Id",
    "Enable",
    "Name",
    "Description",
    "Tag",
    "Menu",
    "Price",
    "Mrp",
    "Images",
    "Videos"
  ];

// food tag list
  RxList<String> tags = <String>[].obs;

  // food menu list
  RxList<String> menus = <String>[].obs;

  // selected tags
  RxString selectedTags = "".obs;

  // selected menus
  RxString selectedMenus = "".obs;

  /* food data for ui table view*/
  RxList<List<String>> foods = <List<String>>[].obs;

  // controllers
  TextEditingController foodName = TextEditingController();
  TextEditingController foodDetails = TextEditingController();
  TextEditingController foodPrice = TextEditingController();
  TextEditingController foodMrp = TextEditingController();
  TextEditingController foodTag = TextEditingController();

  // add food
  get addFood async {
    // loader start
    foodLoading.value = true;

    // // Preparing request body
    // final body = {"name": menuName.text};
    // try {
    //   // calling menu api
    //   final response = await MenuService.addMenu(body: body);

    //   if (response.isNotEmpty) {
    //     log(response.toString());
    //     // Checking user
    //     final temp = response["menu"];

    //     if (temp != null) {
    //       // When temp is not null
    //       log("Temp=> $temp");

    //       FlashMessage.show(
    //           title: "Successful",
    //           message: response["message"].toString(),
    //           isSuccess: true);
    //     }
    //   } else {
    //     // invalid credentials
    //     final message = response["message"];
    //     FlashMessage.show(
    //         title: message.toString(),
    //         message: "Please try again",
    //         isError: true);
    //   }
    // } catch (e) {
    //   return FlashMessage.show(title: e.toString(), isError: true);
    // }
    /* loading end*/
    foodLoading.value = false;

// clearing name controller
    foodName.clear();
  }
}
