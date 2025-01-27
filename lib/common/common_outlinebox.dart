import 'package:fideos_web/model/color.dart';
import 'package:fideos_web/model/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonOutlineBox extends StatelessWidget {
  final String text;

  final double border;

  final bool fontFamily;
  final double? width;
  final Color? color;
  final double opacity;

  const CommonOutlineBox({
    super.key,
    required this.text,
    this.border = 1,
    this.fontFamily = false,
    this.color,
    this.width,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: color!.withOpacity(opacity), width: border),
        borderRadius: BorderRadius.circular(7),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
            color: color ?? AppColor.primary,
            fontFamily: fontFamily ? Fonts.medium : Fonts.regular),
      ),
    );
  }
}
