import 'package:fideos_web/model/font.dart';
import 'package:flutter/material.dart';

class CommonTtile extends StatelessWidget {
  final String titleText;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign align;
  final TextDecoration decoration;
  const CommonTtile(
      {super.key,
      required this.titleText,
      this.fontSize = 15,
      this.fontWeight = FontWeight.w700,
      this.color = Colors.white,
      this.align = TextAlign.start,
      this.decoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      textAlign: align,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: Fonts.regular,
        color: color,
        decoration: decoration,
      ),
    );
  }
}
