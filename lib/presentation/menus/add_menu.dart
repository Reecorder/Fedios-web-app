import 'dart:math';

import 'package:fideos_web/common/common_button.dart';
import 'package:fideos_web/common/common_textfield.dart';
import 'package:fideos_web/common/common_title.dart';
import 'package:fideos_web/model/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/menu_controller.dart';

class AddMenu extends StatefulWidget {
  bool update;
  AddMenu({super.key, required this.update});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  // menu key
  GlobalKey<FormState> menukey =
      GlobalKey<FormState>(debugLabel: Random().nextInt(10).toString());

  final controller = Get.put(MenusController());

  @override
  void initState() {
    super.initState();
    if (widget.update) {
      /* selected menu */
      final menu = controller.selectedMenu.value;
      /* prefilling all the controllers */
      controller.menuName.text = menu.name ?? "";
      controller.menuEnabled.value = menu.enable!;
    } else {
      controller.menuName.clear();
    }
  }

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
        key: menukey,
        child: Column(
          children: [
            // menu name field
            nameField,

            if (widget.update)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(children: [
                      const SizedBox(width: 200, child: Text("Menu Enable")),
                      const SizedBox(width: 15),
                      Obx(() => CupertinoSwitch(
                            value: controller.menuEnabled.value,
                            activeColor: AppColor.primary,
                            onChanged: (value) {
                              controller
                                  .menuEnabled(!controller.menuEnabled.value);
                            },
                          ))
                    ]),
                  ),
                ],
              ),

            const SizedBox(height: 15),

            // submit button
            Obx(() {
              if (controller.menuLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return CommonButton(
                    title: widget.update ? "Update" : "Add",
                    onPressed: () {
                      if (menukey.currentState!.validate()) {
                        // add /update menu
                        widget.update
                            ? controller.updateMenu
                            : controller.addMenu;
                      }
                    });
              }
            })
          ],
        ),
      ),
    );
  }

  // menu name text field
  Widget get nameField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
        child: CommonTextField(
          controller: controller.menuName,
          hint: "Enter Menu Name",
          prefixicon: Icons.restaurant,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Menu name is required";
            }
            return null;
          },
        ),
      );
}
