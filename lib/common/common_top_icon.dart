import 'package:flutter/material.dart';

class CommonIcon extends StatelessWidget {
  final String image;
  const CommonIcon({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: 20,
    );
  }
}
