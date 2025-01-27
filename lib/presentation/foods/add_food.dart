import 'dart:math';

import 'package:fideos_web/common/common_outlinebox.dart';
import 'package:fideos_web/common/common_textfield.dart';
import 'package:fideos_web/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_button.dart';
import '../../common/common_dropdown.dart';
import '../../common/common_subtitle.dart';
import '../../common/common_title.dart';
import '../../model/color.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  // menu key
  GlobalKey<FormState> foodkey =
      GlobalKey<FormState>(debugLabel: Random().nextInt(10).toString());

  final controller = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonTtile(
          titleText: "Add Menu",
          color: AppColor.white,
          fontSize: 20,
        ),
      ),
      body: Form(
        key: foodkey,
        child: Column(
          children: [
            // menu name field
            nameField,

            // tags
            tagField,

            // menus
            menuField,

            // price
            priceField,

            // mrp
            mrpField,

            // details
            detailsField,

            const SizedBox(height: 15),

            // submit button
            Obx(() {
              if (controller.foodLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return CommonButton(
                    title: "Add",
                    onPressed: () {
                      if (foodkey.currentState!.validate()) {
                        // add food
                        controller.addFood;
                      }
                    });
              }
            })
          ],
        ),
      ),
    );
  }

  // food name text field
  Widget get nameField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
        child: CommonTextField(
          controller: controller.foodName,
          hint: "Enter Food Name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Food name is required";
            }
            return null;
          },
        ),
      );

  // food details text field
  Widget get detailsField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
        child: CommonTextField(
          controller: controller.foodDetails,
          maxline: 5,
          hint: "Enter Food details",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Food details is required";
            }
            return null;
          },
        ),
      );

  // food tag drop down field
  Widget get tagField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
        child: Obx(() => CommonDropdown(
            items: controller.tags,
            value: controller.selectedTags.value,
            onChanged: (value) {
              controller.selectedTags.value = value;
            },
            hint: "Tags")),
      );

  // menu drop down field
  Widget get menuField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
        child: Obx(() => CommonDropdown(
            items: controller.menus,
            value: controller.selectedMenus.value,
            onChanged: (value) {
              controller.selectedMenus.value = value;
            },
            hint: "Menus")),
      );

  // food price text field
  Widget get priceField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
        child: CommonTextField(
          controller: controller.foodPrice,
          hint: "Enter Food price",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Food price is required";
            }
            return null;
          },
        ),
      );

  // food mrp text field
  Widget get mrpField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
        child: CommonTextField(
          controller: controller.foodMrp,
          hint: "Enter Food Mrp",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Food MRP is required";
            }
            return null;
          },
        ),
      );
}
