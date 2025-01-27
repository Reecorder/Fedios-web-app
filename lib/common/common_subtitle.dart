import 'package:fideos_web/model/font.dart';
import 'package:flutter/material.dart';

class CommonSubTtile extends StatelessWidget {
  final String titleText;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign align;
  final TextDecoration? decoration;
  const CommonSubTtile({
    super.key,
    required this.titleText,
    this.fontSize = 13,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.white,
    this.align = TextAlign.justify,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      textAlign: align,
      softWrap: true,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: Fonts.regular,
        color: color,
      ),
    );
  }
}
