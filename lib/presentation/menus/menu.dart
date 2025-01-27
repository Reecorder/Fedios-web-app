import 'package:fideos_web/common/common_outlinebox.dart';
import 'package:fideos_web/common/common_scrollbar.dart';
import 'package:fideos_web/presentation/menus/add_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_subtitle.dart';
import '../../common/common_table.dart';
import '../../common/common_title.dart';
import '../../controller/menu_controller.dart';
import '../../model/color.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final controller = Get.put(MenusController());

  @override
  void initState() {
    super.initState();
    controller.fetchMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addButton,
      body: Obx(
        () {
          if (controller.menuLoading.value) {
            return Center(
                child: CircularProgressIndicator(color: AppColor.primary));
          } else {
            return CommonScrollBar(
              child: CommonTable(
                titles: controller.menuTitles,
                data: controller.menus,
                onPressed: (index) {
                  controller.selectedMenu.value = controller.parsedMenu[index];
                  Get.to(() => AddMenu(
                        update: true,
                      ));
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
        // go to add menu screen
        Get.to(() => AddMenu(update: false));
      });
}
