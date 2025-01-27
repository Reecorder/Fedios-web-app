// ignore_for_file: must_be_immutable

import 'package:fideos_web/controller/drawer_controller.dart';
import 'package:fideos_web/model/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  /* importing controller */
  final controller = Get.put(CustomDrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const RoundedRectangleBorder(),
        child: ListView(children: [
          /* drawer header */
          drawerHeader,
          /* screen titles */
          ...List.generate(
              titles.length, (index) => listTile(title: titles[index]))
        ]));
  }

  /* list tile */
  Widget listTile({required String title}) => Obx(() => ListTile(
      onTap: () {
        controller.changeSelection(option: title);
      },
      selectedColor: AppColor.primary,
      selected: controller.selectedOption.value == title,
      title: Text(title)));

  /* available screen titles */
  List<String> titles = [
    "Dashboard",
    "Orders",
    "Reservations",
    "Menu",
    "Food",
    "Profile",
  ];

  /* drawer header */
  DrawerHeader get drawerHeader => DrawerHeader(
      decoration: BoxDecoration(color: AppColor.primary),
      child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Fideos Admin Panel',
              style: TextStyle(color: Colors.white))));
}
