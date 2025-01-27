import 'package:fideos_web/controller/rejection_controller.dart';
import 'package:fideos_web/model/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_subtitle.dart';
import '../../common/common_title.dart';
import '../../common/common_top_icon.dart';

class RejectionScreen extends StatefulWidget {
  const RejectionScreen({super.key});

  @override
  State<RejectionScreen> createState() => _RejectionScreenState();
}

class _RejectionScreenState extends State<RejectionScreen> {
  final controller = Get.put(RejectionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // top section
          topSection,

          Divider(color: AppColor.grey.withOpacity(0.2)),

          //rejection reason
          rejectField,

          const SizedBox(height: 10),

          // submit button
          submit
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
                  titleText: "Reject Order-123456",
                  color: AppColor.black,
                ),
                // sub title
                CommonSubTtile(
                  titleText: "Please provide a proper reason to reject order ",
                  color: AppColor.grey.withOpacity(0.4),
                  fontSize: 11,
                )
              ],
            ),
            const Spacer()
          ],
        ),
      );

  // restaurant name text field
  Widget get rejectField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
        child: TextField(
          controller: controller.rejectionController,
          maxLines: 8,
          decoration: const InputDecoration(
              hintText: "Provide detailed reason to reject this order",
              hintStyle: TextStyle(
                fontSize: 13,
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26))),
        ),
      );

// submit
  Widget get submit => UnconstrainedBox(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const CommonSubTtile(
            titleText: "Submit",
            fontSize: 15,
          ),
        ),
      );
}
