import 'dart:math';

import 'package:fideos_web/common/common_title.dart';
import 'package:fideos_web/presentation/auth/registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../common/common_auth_title.dart';
import '../../common/common_button.dart';
import '../../common/common_divider.dart';
import '../../common/common_textfield.dart';
import '../../controller/auth_controller.dart';
import '../../model/color.dart';
import '../../model/font.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
// login key
  GlobalKey<FormState> loginkey =
      GlobalKey<FormState>(debugLabel: Random().nextInt(10).toString());

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: loginkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title text
                const CommonAuthTtile(
                    titleText: "India's #1 Food Video and Delivery App"),

                // common divider
                const CommonDivider(text: "Log in or Sign up"),

                // text field for email
                emailField,

                // text field for password
                passwordField,

                const SizedBox(height: 3),

                // forgot password
                forgotPassword,

                const SizedBox(height: 2),

                // login button
                Obx(
                  () => controller.loginLoader.value
                      ? const CircularProgressIndicator()
                      : CommonButton(
                          title: "Continue",
                          onPressed: () {
                            if (loginkey.currentState!.validate()) {
                              // login function
                              controller.login;
                            }
                          },
                        ),
                ),

                // common divider
                const CommonDivider(text: "or", verticalPadding: 12),

                // singup text
                singupNow,

                const SizedBox(height: 20),

                // term condition section
                termAndConditionIntro,

                // terms
                termpolicies,

                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }

// terms and policies
  Widget get termpolicies => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // term
            termpoliciesText(text: "Terms of Service"),
            // privacy policy
            termpoliciesText(text: "Privacy Policy"),
            // content policy
            termpoliciesText(text: "Content Policy")
          ],
        ),
      );

// term policies text
  Widget termpoliciesText({required String text}) => Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: AppColor.primary,
          fontFamily: Fonts.semibold,
        ),
      );

// term and condition introduction section
  Widget get termAndConditionIntro => Text(
        "By continuing, you agree to our",
        style: TextStyle(
          fontSize: 12,
          color: AppColor.grey,
          fontFamily: Fonts.regular,
        ),
      );

// sign up now text
  Widget get singupNow => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // don't have account text
          dontHaveAccount,

          // Sign up now text
          signupNowText,
        ],
      );

// don't have account text
  Widget get dontHaveAccount => Text(
        "Don't have an account? ",
        style: TextStyle(
          fontSize: 12,
          color: AppColor.grey,
          fontFamily: Fonts.regular,
        ),
      );

// sign up now text
  Widget get signupNowText => GestureDetector(
        onTap: () {
          Get.to(() => const Registration());
        },
        child: Text(
          "Sign up now",
          style: TextStyle(
            fontSize: 12,
            color: AppColor.primary,
            fontFamily: Fonts.semibold,
          ),
        ),
      );

// forgot password
  Widget get forgotPassword => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Forgot password?",
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 12,
                fontFamily: Fonts.semibold,
              ),
            )
          ],
        ),
      );

// email text field
  Widget get emailField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
        child: CommonTextField(
          controller: controller.emailcontroller,
          hint: "Enter Email address",
          prefixicon: Icons.email_outlined,
          validator: (email) {
            if (email == null || email.isEmpty) {
              return "Email address is required";
            } else if (!email.isEmail) {
              return "This is not a valid email address";
            }
            return null;
          },
        ),
      );

// password text field
  Widget get passwordField => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: CommonTextField(
            controller: controller.passwordcontroller,
            hint: "Enter Password",
            prefixicon: Icons.lock_outline_rounded,
            /* suffix icon changed based on the obsecurity */
            suffixicon: controller.obsecure.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            obsecure: controller.obsecure.value,
            changeobsecure: () {
              /* changing password obsecure status */
              controller.changeobsecure;
            },
            validator: (password) {
              // regex format for password validator
              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
              if (password == null || password.isEmpty) {
                return "Password is required";
              } else {
                if (!regex.hasMatch(password)) {
                  return 'Enter valid password';
                }
              }
              return null;
            },
          ),
        ),
      );
}
