import 'dart:developer';

import 'package:fideos_web/common/common_scrollbar.dart';
import 'package:fideos_web/common/common_table.dart';
import 'package:fideos_web/controller/category_controller.dart';
import 'package:fideos_web/model/color.dart';
import 'package:fideos_web/presentation/categories/add_category.dart';
import 'package:fideos_web/presentation/categories/update_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    controller.fetchCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addButton,
      body: Obx(
        () {
          if (controller.categoriesLoading.value) {
            return Center(
                child: CircularProgressIndicator(color: AppColor.primary));
          } else {
            return CommonScrollBar(
              child: CommonTable(
                titles: controller.categoryTitles,
                data: controller.categories,
                onPressed: (index) {
                  controller.selectedCategory.value =
                      controller.categoriesParsed[index];
                  Get.to(() => const UpdateCategories());
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
        Get.to(() => AddCategories());
      });
}
