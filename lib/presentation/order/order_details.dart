import 'package:fideos_web/common/common_subtitle.dart';
import 'package:fideos_web/model/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_outlinebox.dart';
import '../../common/common_title.dart';
import '../../common/common_top_icon.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // back icon
              backButton,

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

              // order id
              CommonOutlineBox(
                text: "Order-1234567",
                width: Get.width * 0.4,
                opacity: 0.4,
                color: AppColor.black,
              ),

              const SizedBox(height: 10),

              // customer name
              CommonSubTtile(
                titleText: "Joy Bhattacherjee",
                color: AppColor.black,
                fontSize: 15,
                align: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),

              const SizedBox(height: 5),

              // customer name
              CommonSubTtile(
                titleText: "DN-24, Saltlake, Sector 5, Kolkata",
                color: AppColor.black,
                align: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // delivery partner status
              const CommonSubTtile(
                titleText: "Delivery Partner Waiting",
                fontSize: 14,
                color: Color(0xff007713),
                fontWeight: FontWeight.bold,
              ),

              // product list
              productList,

              const SizedBox(height: 10),
              // order ready tile
              CommonOutlineBox(
                text: "Food is Ready",
                width: Get.width * 0.4,
                color: const Color(0xff007713),
              ),

              // food preparation
              CommonOutlineBox(
                text: "Start Preparation",
                width: Get.width * 0.4,
                color: const Color(0xffA69500),
              ),
            ],
          ),
        ),
      ),
    );
  }

// product list
  Widget get productList => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 2,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(left: 5, right: 5),
        children: List.generate(6, (index) => productTile),
      );

  // product tile
  Widget get productTile => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.grey.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // product id
          CommonTtile(
            titleText: "Product-12345",
            color: AppColor.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),

          // product quantity
          CommonSubTtile(
            titleText: "Kadai Panner x 2",
            color: AppColor.black,
            fontSize: 11,
          ),
        ]),
      );

// back button
  Widget get backButton => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Align(
              alignment: Alignment.topLeft,
              child: CommonIcon(image: "assets/back_image.png")),
        ),
      );
}
