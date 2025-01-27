import 'package:fideos_web/common/common_outlinebox.dart';
import 'package:fideos_web/common/common_scrollbar.dart';
import 'package:fideos_web/controller/food_controller.dart';
import 'package:fideos_web/presentation/foods/add_food.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_subtitle.dart';
import '../../common/common_table.dart';
import '../../common/common_title.dart';
import '../../controller/menu_controller.dart';
import '../../model/color.dart';

class Foods extends StatefulWidget {
  const Foods({super.key});

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  final controller = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addButton,
      body: Obx(
        () {
          if (controller.foodLoading.value) {
            return Center(
                child: CircularProgressIndicator(color: AppColor.primary));
          } else {
            return CommonScrollBar(
              child: CommonTable(
                titles: controller.foodTitles,
                data: controller.foods,
                onPressed: (index) {
                  // controller.selectedCategory.value =
                  //     controller.categoriesParsed[index];
                  // Get.to(() => const UpdateCategories());
                },
              ),
            );
          }
        },
      ),
    );
  }

  /* add button */
  Widget get addButton => FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: AppColor.primary,
      child: const Icon(Icons.add, color: Colors.white),
      onPressed: () {
        // go to add Foods screen
        Get.to(() => AddFood());
      });
}
