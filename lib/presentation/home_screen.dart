import 'package:fideos_web/controller/drawer_controller.dart';
import 'package:fideos_web/presentation/drawer/drawer_screen.dart';
import 'package:fideos_web/presentation/foods/foods.dart';
import 'package:fideos_web/model/color.dart';
import 'package:fideos_web/model/font.dart';
import 'package:fideos_web/presentation/categories/category_screen.dart';
import 'package:fideos_web/presentation/customers/customer_screen.dart';
import 'package:fideos_web/presentation/order/order.dart';
import 'package:fideos_web/presentation/foods/add_food.dart';
import 'package:fideos_web/presentation/menus/menu.dart';
import 'package:fideos_web/presentation/product/products.dart';
import 'package:fideos_web/presentation/reservation/reservations.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  /* importing controller */
  final controller = Get.put(CustomDrawerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: appBar,
        body: Obx(() {
          Widget screen = const SizedBox();
          /* change selected screen */
          switch (controller.selectedOption.value) {
            case "Dashboard":
              screen = const SizedBox();
            case "Orders":
              screen = const OrderScreen();
              break;
            case "Reservations":
              screen = const Reservations();
              break;
            case "Menu":
              screen = const Menu();

              break;
            case "Food":
              screen = const Foods();

              break;
            case "Profile":
              screen = const SizedBox();
              break;
            default:
          }
          return screen;
        }));
  }

  /* base app bar */
  PreferredSize get appBar =>
      PreferredSize(preferredSize: size, child: appBarWidget);

  /* appbar */
  AppBar get appBarWidget => AppBar(
      title: appbarTitle,
      centerTitle: false,
      backgroundColor: AppColor.primary);

  /* appbar title */
  Widget get appbarTitle => Obx(
        () => Text(
          controller.selectedOption.value,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: Fonts.regular),
        ),
      );

  /* preferred size */
  Size get size => const Size(double.infinity, 50);
}
