import 'package:flutter/material.dart';

import '../model/font.dart';

class CommonAuthTtile extends StatelessWidget {
  final String titleText;
  final double fontSize;
  const CommonAuthTtile({
    super.key,
    required this.titleText,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 25),
      child: Text(
        titleText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          fontFamily: Fonts.medium,
        ),
      ),
    );
  }
}
