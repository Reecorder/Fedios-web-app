import 'package:fideos_web/controller/category_controller.dart';
import 'package:fideos_web/model/color.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/common_button.dart';
import '../../common/common_textfield.dart';

class UpdateCategories extends StatefulWidget {
  const UpdateCategories({super.key});

  @override
  State<UpdateCategories> createState() => _UpdateCategoriesState();
}

class _UpdateCategoriesState extends State<UpdateCategories> {
  // Controller
  final controller = Get.put(CategoryController());
  @override
  void initState() {
    super.initState();
    controller.categoryNameController.text =
        controller.selectedCategory.value.name ?? "";
    controller.categoryEnabled.value =
        controller.selectedCategory.value.enable ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // category Name Field
            categoryNameField,

            Row(children: [
              const SizedBox(width: 200, child: Text("Customer Enable")),
              const SizedBox(width: 15),
              Obx(() => CupertinoSwitch(
                    value: controller.categoryEnabled.value,
                    activeColor: AppColor.primary,
                    onChanged: (value) {
                      controller
                          .categoryEnabled(!controller.categoryEnabled.value);
                    },
                  ))
            ]),

            // update button
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: updateButton,
            )
          ],
        ),
      ),
    );
  }

  // category Name Field
  Widget get categoryNameField => CommonTextField(
        controller: controller.categoryNameController,
        hint: "Category Name",
      );

  // Update Button
  Widget get updateButton => Obx(
        () => controller.categoriesLoading.value
            ? CircularProgressIndicator(color: AppColor.primary)
            : CommonButton(
                onPressed: () async {
                  // update category
                  controller.updateCategory;
                },
                title: "Update",
              ),
      );

  /* base app bar */
  PreferredSize get appBar =>
      PreferredSize(preferredSize: size, child: appBarWidget);

  /* appbar */
  AppBar get appBarWidget => AppBar(
        title: appbarTitle,
        centerTitle: false,
        backgroundColor: AppColor.primary,
      );

  /* appbar title */
  Widget get appbarTitle => const Text("Fideos Admin Panel - Update Categories",
      style: TextStyle(color: Colors.white, fontSize: 17));

  /* preferred size */
  Size get size => const Size(double.infinity, 50);
}
