import 'package:fideos_web/model/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/font.dart';

class FlashMessage {
  static show(
          {required String title,
          bool isSuccess = false,
          bool isError = false,
          String? message}) =>
      Get.snackbar(title, message ?? "",
          isDismissible: true,
          duration: const Duration(seconds: 5),
          backgroundColor: AppColor.white.withOpacity(0.8),
          // Showing customised title text
          titleText: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.0,
                fontFamily: Fonts.regular,
                color: isSuccess
                    ? Colors.green
                    : isError
                        ? Colors.red
                        : Colors.black),
          ),
          // Showing customised message text
          messageText: message == null
              ? const SizedBox()
              : Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: Fonts.regular,
                      color: Colors.black),
                ));
}
