// import 'package:fideos_web/common/common_outlinebox.dart';
// import 'package:fideos_web/common/common_scrollbar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../common/common_subtitle.dart';
// import '../../common/common_table.dart';
// import '../../common/common_title.dart';
// import '../../controller/menu_controller.dart';
// import '../../model/color.dart';

// class Menu extends StatefulWidget {
//   const Menu({super.key});

//   @override
//   State<Menu> createState() => _MenuState();
// }

// class _MenuState extends State<Menu> {
//   final controller = Get.put(MenusController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: addButton,
//       body: Obx(
//         () {
//           if (controller.menuLoading.value) {
//             return Center(
//                 child: CircularProgressIndicator(color: AppColor.primary));
//           } else {
//             return CommonScrollBar(
//               child: CommonTable(
//                 titles: controller.menuTitles,
//                 data: controller.menus,
//                 onPressed: (index) {
//                   // controller.selectedCategory.value =
//                   //     controller.categoriesParsed[index];
//                   // Get.to(() => const UpdateCategories());
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   /* add button */
//   Widget get addButton => FloatingActionButton(
//       shape: const CircleBorder(),
//       backgroundColor: AppColor.primary,
//       child: const Icon(Icons.add, color: Colors.white),
//       onPressed: () {
//         // go to add menu screen
//       });

//   // menu tile
//   Widget get menuTile => ListTile(
//         title: menuTitle,
//         subtitle: menuSubTitle,
//         shape: Border(
//           top: BorderSide(color: AppColor.black.withOpacity(0.5)),
//         ),
//       );

// //  menu title
//   Widget get menuTitle => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // title
//           CommonTtile(
//             titleText: "Veg Items",
//             color: AppColor.black,
//             fontSize: 14,
//           ),
//           // menu ID
//           CommonSubTtile(
//             titleText: "Id: 1234567",
//             color: AppColor.black,
//             fontSize: 13,
//           )
//         ],
//       );

// // menu sub title
//   Widget get menuSubTitle => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // title
//           CommonSubTtile(
//             titleText: "10 food items available in this menu",
//             color: AppColor.black,
//             fontSize: 13,
//           ),
//           // menu ID
//           CommonSubTtile(
//             titleText: "Enabled",
//             color: Colors.green,
//             fontSize: 13,
//           )
//         ],
//       );
// }
