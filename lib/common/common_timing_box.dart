import 'package:fideos_web/model/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'common_subtitle.dart';

class CommonTimingBox extends StatelessWidget {
  final String text;
  final bool icon;
  const CommonTimingBox({super.key, required this.text, this.icon = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: AppColor.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon
          icon ? const Icon(FeatherIcons.clock, size: 20) : const SizedBox(),

          SizedBox(width: icon ? 6 : 0),

          // arrival time text
          CommonSubTtile(
            titleText: text,
            color: AppColor.black,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
