import 'package:fideos_web/common/common_outlinebox.dart';
import 'package:fideos_web/presentation/product/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_subtitle.dart';
import '../../common/common_title.dart';
import '../../model/color.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // title
            CommonTtile(
              titleText: "Domino's Pizza",
              color: AppColor.black,
              fontSize: 21,
              align: TextAlign.center,
            ),

            // sub title
            CommonSubTtile(
              titleText: "Saltlake Sector 3, Bidhannagar, Kolkata",
              color: AppColor.black,
              fontSize: 13,
              align: TextAlign.center,
            ),

            // add product
            CommonOutlineBox(
              text: "Add Product",
              color: AppColor.primary,
              width: Get.width * 0.5,
              fontFamily: true,
            ),

            // product list
            Expanded(
              child: ListView(
                children: List.generate(
                  6,
                  (index) => productTile(index: index),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // product tile
  Widget productTile({required int index}) => GestureDetector(
        onTap: () {
          Get.to(() => const EditProdut());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              5.0,
            ),
            border: Border.all(color: AppColor.grey.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              //  product image
              productImage,

              const SizedBox(width: 7),
              // product details
              productDetails,
            ],
          ),
        ),
      );

  // product image
  Widget get productImage => SizedBox(
        height: 120,
        width: 95,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            "assets/delicious-pizza.png",
            fit: BoxFit.fitHeight,
          ),
        ),
      );

// product details
  Widget get productDetails => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // product name
              productName,

              const SizedBox(width: 10),

              // best seller tag
              bestSellerTag,
            ],
          ),

          // product description
          productDescription,

          const SizedBox(height: 3),

          // restuarant  name
          restuarantName,

          const SizedBox(height: 3),

          // product price
          Row(
            children: [
              // discounted price
              discountedPrice,

              const SizedBox(width: 5),
              // original price
              originalPrice
            ],
          )
        ],
      );

  // product name
  Widget get productName => CommonSubTtile(
        titleText: "Special Chicken Biryani",
        color: AppColor.black,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      );

// best seller tag
  Widget get bestSellerTag => CommonSubTtile(
        titleText: "Best Seller",
        color: AppColor.primary,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      );

// product description
  Widget get productDescription => SizedBox(
        width: Get.width * 0.65,
        child: const CommonSubTtile(
          titleText: "Kadai Paneer islls warming ssg mkdm dish...",
          color: Colors.black87,
          fontSize: 12,
        ),
      );

// restuarant name
  Widget get restuarantName => CommonSubTtile(
        titleText: "Kolkata Biryani",
        color: AppColor.black,
        fontSize: 12.5,
        fontWeight: FontWeight.bold,
      );

// deiscounted price
  Widget get discountedPrice => CommonSubTtile(
        titleText: "\$200",
        color: AppColor.black,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      );

// original price
  Widget get originalPrice => CommonSubTtile(
        titleText: "\$300",
        color: AppColor.black,
        fontSize: 14,
        decoration: TextDecoration.lineThrough,
      );
}
