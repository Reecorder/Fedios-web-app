import 'package:fideos_web/model/color.dart';
import 'package:fideos_web/presentation/order/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/common_subtitle.dart';
import '../../common/common_title.dart';

import 'rejection_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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

            const SizedBox(height: 10),

            // order list
            Expanded(
              child: ListView(
                  children:
                      List.generate(6, (index) => orderTile(index: index))),
            ),
          ],
        ),
      ),
    );
  }

  // delivered order tile
  Widget orderTile({required int index}) => GestureDetector(
        onTap: () {
          Get.to(() => const OrderDetails());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              5.0,
            ),
            border: Border.all(color: AppColor.grey.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // order id
              CommonSubTtile(
                titleText: "Order-123456",
                color: AppColor.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),

              // restuarant outlet
              restuarantOutlet(index: index),

              // order items
              CommonSubTtile(
                titleText: "Kadai Panner, Chicken Biriyani and..",
                color: AppColor.black,
                fontSize: 13,
              ),

              // order date
              const SizedBox(height: 3),

              CommonSubTtile(
                titleText: "Ordered On 6.08 p.m.",
                color: AppColor.black,
                fontSize: 13,
              ),

              const SizedBox(height: 3),
              // delivery partner details
              CommonSubTtile(
                titleText: "Delivery Partner not assigned",
                color: AppColor.primary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
      );

  // order items
  Widget restuarantOutlet({required int index}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // order outlet location
          CommonSubTtile(
            titleText: "From Domino's Pizza, Kolkata",
            color: AppColor.black,
            fontSize: 13,
          ),

          // order status
          orderStatus(index: index)
        ],
      );

  // order status
  Widget orderStatus({required int index}) => GestureDetector(
        onTap: () {
          index % 2 != 0
              ? Get.dialog(barrierDismissible: false, rejectDialog)
              : const SizedBox();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: CommonSubTtile(
            titleText: index % 2 != 0 ? "Reject" : "Confirm",
            color: index % 2 != 0 ? Colors.red : Colors.green,
          ),
        ),
      );

// reject dialog
  Widget get rejectDialog => SimpleDialog(
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.all(8),
        contentPadding: const EdgeInsets.all(10),
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        // title
        title: CommonTtile(
          titleText: "Are you sure to reject Order-1234567?",
          color: AppColor.black,
          fontSize: 14,
        ),
        titlePadding: const EdgeInsets.only(left: 30, right: 0, top: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        children: [
          // reject description
          CommonSubTtile(
            titleText:
                "This will require to submit a proper reject reason and if the reason does not stand back you will face a penalty according to the order value.",
            color: AppColor.black,
            fontSize: 12,
            align: TextAlign.center,
          ),

          // back to order button
          unConstrainBox(
              text: "Go Back to Order",
              color: Colors.green,
              width: Get.width * 0.2,
              onTap: () {
                Get.back();
              }),

          // reject button
          unConstrainBox(
              text: "I have Understand & Reject this Order",
              color: AppColor.primary,
              width: Get.width * 0.4,
              onTap: () {
                Get.back();
                Get.to(() => const RejectionScreen());
              })
        ],
      );

  // unconstrain box
  Widget unConstrainBox(
          {required String text,
          Color? color,
          double? width,
          required Function onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: UnconstrainedBox(
          child: Container(
            width: width ?? Get.width * 0.4,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: color ?? AppColor.grey),
            ),
            child:

                // arrival time text
                CommonSubTtile(
              titleText: text,
              color: color ?? AppColor.black,
              align: TextAlign.center,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );
}
