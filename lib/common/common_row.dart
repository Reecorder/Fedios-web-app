import 'package:flutter/material.dart';

class CommonRowWidget extends StatelessWidget {
  const CommonRowWidget(
      {super.key,
      required this.widget,
      required this.hint,
      this.widget2 = const SizedBox()});

  final Widget widget;
  final String hint;
  final Widget widget2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /* hint text */
        SizedBox(width: 200, child: Text(hint)),

        /* space */
        const SizedBox(width: 15),
        widget,
        const SizedBox(width: 15),
        widget2
      ],
    );
  }
}
