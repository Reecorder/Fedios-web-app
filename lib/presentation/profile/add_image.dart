import 'package:fideos_web/common/common_button.dart';
import 'package:fideos_web/controller/profile_controller.dart';
import 'package:fideos_web/model/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_subtitle.dart';
import '../../common/common_title.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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

              const SizedBox(height: 20),

              // asking for photos text
              CommonTtile(
                titleText: "Give us some photos of your restaurant",
                color: AppColor.black,
                fontSize: 17,
                align: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // waring text
              waringText,
              // add image button
              addImageButton,
              const SizedBox(height: 10),
              // restaurant  image list
              imageList,

              const SizedBox(height: 20),

              // upload button
              CommonButton(title: "Upload", onPressed: () {})
            ]),
      )),
    );
  }

//restaurant example text
  Widget get waringText => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonSubTtile(
              titleText: " *add atleast 1 Image",
              fontSize: 11,
              color: AppColor.primary,
            )
          ],
        ),
      );

  // restaurant image list
  Widget get imageList => Obx(() {
        if (controller.selectedImages.isEmpty) {
          return const SizedBox();
        } else {
          return GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(controller.selectedImages.length,
                  (index) => imageTile(index)));
        }
      });

// image tile
  Widget imageTile(int index) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // picked image
          Expanded(
            child: Image.network(
              controller.selectedImages[index].path,
              fit: BoxFit.fitWidth,
            ),
          ),

          const SizedBox(height: 5),

          // remove image button
          GestureDetector(
            onTap: () {
              controller.selectedImages.removeAt(index);
            },
            child: CommonSubTtile(
              titleText: "Remove",
              fontSize: 12,
              color: AppColor.primary,
            ),
          )
        ],
      );

  /* add image button */
  Widget get addImageButton => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Align(
          alignment: Alignment.center,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                controller.pickImage;
                setState(() {});
              },
              child: const Text("Select Image",
                  style: TextStyle(color: Colors.black))),
        ),
      );
}
