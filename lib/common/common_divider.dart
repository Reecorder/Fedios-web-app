import 'package:flutter/material.dart';

import '../model/color.dart';

class CommonDivider extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final String text;

  const CommonDivider(
      {super.key,
      this.horizontalPadding = 15,
      this.verticalPadding = 0,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // divider
          divider,

          // text
          divierText(text: text),

          // divider
          divider
        ],
      ),
    );
  }

  // divider
  Widget get divider => Expanded(
          child: Divider(
        color: AppColor.grey,
      ));

// divider text
  Widget divierText({required String text}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Text(
          text,
          style: TextStyle(
            color: AppColor.grey,
            fontSize: 12,
          ),
        ),
      );
}
