import 'package:fideos_web/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_outlinebox.dart';
import '../../common/common_subtitle.dart';
import '../../common/common_textfield.dart';
import '../../common/common_title.dart';
import '../../common/common_top_icon.dart';
import '../../model/color.dart';

class EditProdut extends StatefulWidget {
  const EditProdut({super.key});

  @override
  State<EditProdut> createState() => _EditProdutState();
}

class _EditProdutState extends State<EditProdut> {
  final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // top section
          topSection,

          Divider(color: AppColor.grey.withOpacity(0.2)),

          // product name
          productNameField,

          // product description
          descriptionField,

          // tag list
          tagList,

          // new tag field
          productTagField,

          // tag list
          tagList,

          // new menu
          newMenuField,

          const SizedBox(height: 15),

          // offer price
          productOfferPriceField,

          // actual price
          productActualPriceField,

          // add image
          addImage,

          // save
          CommonOutlineBox(
            text: "Save",
            color: AppColor.primary,
            fontFamily: true,
          )
        ],
      ),
    );
  }

  // top section
  Widget get topSection => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // back button
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const CommonIcon(image: "assets/back_image.png")),

            const Spacer(),

            Column(
              children: [
                // Titte
                CommonTtile(
                  titleText: "Details of Product-123456",
                  color: AppColor.black,
                ),

                // sub title
                CommonSubTtile(
                  titleText: "You can edit or add new product here",
                  color: AppColor.grey.withOpacity(0.4),
                  fontSize: 11,
                ),
              ],
            ),
            const Spacer()
          ],
        ),
      );

  // description field
  Widget get descriptionField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: TextField(
          controller: controller.productDescriptionController,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: "Provide detailed reason to reject this order",
            hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey.withOpacity(0.9),
            ),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26)),
          ),
        ),
      );

// product name
  Widget get productNameField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.productNameController,
          hint: "Enter Product Name",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Product name is required";
            }
            return null;
          },
        ),
      );

  // product Tag
  Widget get productTagField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.productTagController,
          hint: "Enter Product Tag",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Product tag is required";
            }
            return null;
          },
        ),
      );

  // product offer price
  Widget get productOfferPriceField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.offerPriceController,
          hint: "Enter Product offer price",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Product offer price is required";
            }
            return null;
          },
        ),
      );

  // product actual price
  Widget get productActualPriceField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.actualpriceController,
          hint: "Enter Product actual price",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Product offer actual is required";
            }
            return null;
          },
        ),
      );

  // new menu field
  Widget get newMenuField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.newMenuController,
          hint: "Enter new menu",
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "New menu is required";
            }
            return null;
          },
        ),
      );

// tag list
  Widget get tagList => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 55,
          width: Get.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: List.generate(6, (index) => tagTile),
          ),
        ),
      );

// tag tile
  Widget get tagTile => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.grey.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child:
            // product tag name
            const CommonTtile(
          titleText: "Best Seller",
          color: Colors.black54,
          fontSize: 12,
        ),
      );

// add image
  Widget get addImage => Align(
        alignment: Alignment.centerLeft,
        child: UnconstrainedBox(
          child: Container(
            width: Get.width * 0.3,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.black),
              borderRadius: BorderRadius.circular(4),
            ),
            child: CommonSubTtile(
              titleText: "Add Image",
              color: AppColor.black,
            ),
          ),
        ),
      );
}
