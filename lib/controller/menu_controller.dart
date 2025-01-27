import 'dart:developer';

import 'package:fideos_web/presentation/menus/menu.dart';
import 'package:fideos_web/model/menu_model.dart';
import 'package:fideos_web/services/auth_services.dart';
import 'package:fideos_web/services/cookie.dart';
import 'package:fideos_web/services/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/common_flash_msg.dart';

class MenusController extends GetxController {
// loader
  RxBool menuLoading = false.obs;

  // menu titles
  List<String> menuTitles = [
    "Id",
    "Enable",
    "Name",
    "Food Items",
  ];

  /* menu enabled */
  RxBool menuEnabled = false.obs;

  /* menu data for ui table view*/
  RxList<List<String>> menus = <List<String>>[].obs;

  /* Menu data - menu model format */
  RxList<MenuModel> parsedMenu = <MenuModel>[].obs;

  // selected menu
  Rx<MenuModel> selectedMenu = MenuModel().obs;

  /* controller for adding menu  */
  TextEditingController menuName = TextEditingController();

  // add menu
  get addMenu async {
    // loader start
    menuLoading.value = true;

    // Preparing request body
    final body = {"name": menuName.text};
    try {
      // calling menu api
      final response = await MenuService.addMenu(body: body);

      if (response.isNotEmpty) {
        log(response.toString());
        // Checking user
        final temp = response["menu"];

        if (temp != null) {
          // When temp is not null
          log("Temp=> $temp");
          fetchMenu;
          Get.back();
        }
      } else {
        // invalid credentials
        final message = response["message"];
        FlashMessage.show(
            title: message.toString(),
            message: "Please try again",
            isError: true);
      }
    } catch (e) {
      return FlashMessage.show(title: e.toString(), isError: true);
    }
    /* loading end*/
    menuLoading.value = false;

    // clearing name controller
    menuName.clear();
  }

  // fetch menu
  get fetchMenu async {
    // loader start
    menuLoading.value = true;
    try {
      // calling menu api
      final response = await MenuService.fetchMenu();
      if (response.isNotEmpty) {
        log(response.toString());
        // Checking user
        final temp = response["menu"];
        if (temp != null) {
          // When temp is not null
          log("Temp=> $temp");
          parsedMenu.clear();
          menus.clear();
          // looping through the temp list
          for (var i in temp) {
            /* parsing into menu object */
            MenuModel menu = MenuModel.fromJson(i);
            // adding menu object in parsed menu list
            parsedMenu.add(menu);
            // adding menus to the data table list
            menus.add([
              menu.id.toString(),
              menu.enable.toString(),
              menu.name.toString(),
              menu.foodItems.toString()
            ]);
          }
          debugPrint("List of menus=> $menus");
          menus.refresh();
        }
      } else {
        // invalid credentials
        final message = response["message"];
        FlashMessage.show(
            title: message.toString(),
            message: "Please try again",
            isError: true);
      }
    } catch (e) {
      return FlashMessage.show(title: e.toString(), isError: true);
    }
    /* loading end*/
    menuLoading.value = false;
    // clearing name controller
    menuName.clear();
  }

// update menu
  get updateMenu async {
    // loader start
    menuLoading.value = true;

    // Preparing request body
    final body = {"name": menuName.text, "enable": menuEnabled.value};
    try {
      // calling menu api
      final response = await MenuService.updateMenu(body: body);

      if (response.isNotEmpty) {
        log(response.toString());
        // storing in temporary veriable
        final temp = response["menu"];
        // checking temp veriable
        if (temp != null) {
          // When temp is not null
          log("Temp=> $temp");
          fetchMenu;
          Get.back();
        }
      } else {
        // invalid credentials
        final message = response["message"];
        FlashMessage.show(
            title: message.toString(),
            message: "Please try again",
            isError: true);
      }
    } catch (e) {
      return FlashMessage.show(title: e.toString(), isError: true);
    }
    /* loading end*/
    menuLoading.value = false;
  }
}
