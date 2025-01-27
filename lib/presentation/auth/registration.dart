import 'dart:math';
import 'dart:developer' as dev;

import 'package:fideos_web/controller/auth_controller.dart';
import 'package:fideos_web/model/color.dart';
import 'package:fideos_web/model/font.dart';
import 'package:fideos_web/presentation/auth/login.dart';
import 'package:fideos_web/services/google_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_auth_title.dart';
import '../../common/common_button.dart';
import '../../common/common_divider.dart';
import '../../common/common_outlinebox.dart';
import '../../common/common_subtitle.dart';
import '../../common/common_textfield.dart';
import '../../common/common_title.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // registration key
  GlobalKey<FormState> registrationkey =
      GlobalKey<FormState>(debugLabel: Random().nextInt(10).toString());

  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const CommonTtile(titleText: "Fideos", fontSize: 25),
      ),
      body: Center(
        child: Form(
            key: registrationkey,
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
                  nameField,

                  // email text field
                  emailField,

                  // text field for password
                  passwordField,

                  //confirm password
                  confirmpasswordField,

                  const SizedBox(height: 3),

                  // common divider
                  const CommonDivider(text: "Fetch Current Location"),

                  // current location button
                  getCurrentLocation,

                  // common divider
                  const CommonDivider(
                      text: "Enter Location Manually", verticalPadding: 10),

                  // full address filed
                  fullAddressField,

                  // state field
                  stateField,

                  // city filed
                  cityField,

                  // zipcode field
                  zipcodeField,

                  // common divider
                  const CommonDivider(
                      text: "Your Food Type", verticalPadding: 10),

                  //  food type
                  selectFoodType,

                  // common divider
                  const CommonDivider(
                      text: "Restaurant Timing", verticalPadding: 10),

                  // opeing time
                  opeingTimeField,

                  // closing time
                  closingTimeField,

                  // common divider
                  const CommonDivider(
                      text: "Restaurant Open Days", verticalPadding: 10),

                  // restuarant open days
                  restuarantOpendays,

                  // common divider
                  const CommonDivider(
                      text: "Dinning/Dinner Availability", verticalPadding: 10),

                  // services
                  availableServices,

                  // common divider
                  const CommonDivider(
                      text: "Serving Foods", verticalPadding: 10),

                  // serving food example
                  servingfoodExampleText,

                  const SizedBox(height: 10),

                  // serving food fields
                  ...List.generate(controller.dataArray.length,
                      (index) => dynamicForm(index)),

                  // add more button
                  addmoreServingBtn,

                  // common divider
                  const CommonDivider(
                      text: "Contact Details", verticalPadding: 10),

                  // contact email text field
                  contactmailField,

                  // contact phone text field
                  contactPhnField,

                  const SizedBox(height: 20),

                  // registration button

                  Obx(() {
                    if (controller.registerLoader.value) {
                      return const CircularProgressIndicator();
                    } else {
                      return CommonButton(
                          title: "Register",
                          onPressed: () {
                            if (registrationkey.currentState!.validate()) {
                              // registration function
                              controller.register;
                              dev.log("ccddcd");
                            }
                          });
                    }
                  }),

                  // common divider
                  const CommonDivider(text: "or", verticalPadding: 12),

                  // login now
                  loginNow,

                  const SizedBox(height: 25),
                ],
              ),
            )),
      ),
    );
  }

// add more serving food button
  Widget get addmoreServingBtn => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  // adding more field

                  setState(() {
                    controller.addMore;
                  });
                },
                child: CommonSubTtile(
                  titleText: "Add more",
                  color: AppColor.primary,
                  fontSize: 12,
                  align: TextAlign.left,
                )),
          ],
        ),
      );

// dynamic form
  Widget dynamicForm(int key) {
    TextEditingController controllerr;
    if (key >= controller.controllers.length) {
      controllerr = TextEditingController();
      controller.controllers.add(controllerr);
    } else {
      controllerr = controller.controllers[key];
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 12, right: 12),
      child: TextFormField(
        controller: controllerr,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          suffixIcon: key > 0
              ? IconButton(
                  icon: const Icon(Icons.cancel_outlined),
                  onPressed: () {
                    controller.removeField(key);
                    setState(() {});
                  },
                )
              : const SizedBox(),
          hintText: 'Serving ${key + 1}',
          label: Text(
            'Serving ${key + 1}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.withOpacity(0.9),
            ),
          ),
        ),
        onChanged: (val) => controller.onUpdate(key, val),
      ),
    );
  }

// available services
  Widget get availableServices => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            // title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTtile(
                  titleText: "Dinnig Available",
                  color: AppColor.black.withOpacity(0.7),
                  fontSize: 15,
                ),
                // dinning availability  switch
                Obx(
                  () => CupertinoSwitch(
                      value: controller.dinning.value,
                      onChanged: (val) {
                        controller.dinning.value = !controller.dinning.value;
                        dev.log(controller.dinning.value.toString());
                      },
                      activeColor: AppColor.primary),
                ),
              ],
            ),
            const SizedBox(width: 20),

            // delivery availability title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTtile(
                  titleText: "Delivery Available",
                  color: AppColor.black.withOpacity(0.7),
                  fontSize: 15,
                ),

                // delivery availability
                Obx(
                  () => CupertinoSwitch(
                      value: controller.delivery.value,
                      onChanged: (val) {
                        controller.delivery.value = !controller.delivery.value;
                        dev.log(controller.delivery.value.toString());
                      },
                      activeColor: AppColor.primary),
                ),
              ],
            ),
          ],
        ),
      );

  TextEditingController controllerr = TextEditingController();

  // serrving food example text
  Widget get servingfoodExampleText => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            CommonSubTtile(
              titleText: "Serving foods like chinese,indian etc.",
              color: AppColor.grey,
              fontSize: 12,
            ),
            CommonSubTtile(
              titleText: " *add atleast 1 items",
              fontSize: 11,
              color: AppColor.primary,
            )
          ],
        ),
      );

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

// Login now text
  Widget get loginNow => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // already have account text
          alreadyHaveAccount,

          // login now text
          loginNowText,
        ],
      );

// already have account text
  Widget get alreadyHaveAccount => Text(
        "Already have an account? ",
        style: TextStyle(
          fontSize: 12,
          color: AppColor.grey,
          fontFamily: Fonts.regular,
        ),
      );

// sign up now text
  Widget get loginNowText => GestureDetector(
        onTap: () {
          Get.to(() => const LoginScreen());
        },
        child: Text(
          "Login now",
          style: TextStyle(
            fontSize: 12,
            color: AppColor.primary,
            fontFamily: Fonts.semibold,
          ),
        ),
      );

  // restaurant name text field
  Widget get nameField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
        child: CommonTextField(
          controller: controller.namecontroller,
          hint: "Enter Restuarant Name",
          prefixicon: Icons.restaurant,
          validator: (email) {
            if (email == null || email.isEmpty) {
              return "Restuarnt name is required";
            }
            return null;
          },
        ),
      );

// email text field
  Widget get emailField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.regemailcontroller,
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: CommonTextField(
            controller: controller.regpasswordcontroller,
            hint: "Enter Password",
            prefixicon: Icons.lock_outline_rounded,
            /* suffix icon changed based on the obsecurity */
            suffixicon: controller.regobsecure1.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            obsecure: controller.regobsecure1.value,
            changeobsecure: () {
              /* changing password obsecure status */
              controller.changeobsecurereg1;
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

  // confirm password text field
  Widget get confirmpasswordField => Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: CommonTextField(
              controller: controller.regconfirmpasswordcontroller,
              hint: "Confirm Password",
              prefixicon: Icons.lock_outline_rounded,
              /* suffix icon changed based on the obsecurity */
              suffixicon: controller.regobsecure2.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              obsecure: controller.regobsecure2.value,
              changeobsecure: () {
                /* changing password obsecure status */
                controller.changeobsecurereg2;
              },
              validator: (confirmpassword) {
                if (confirmpassword == null || confirmpassword.isEmpty) {
                  return "Confirm password is required";
                } else if (confirmpassword !=
                    controller.regpasswordcontroller.text) {
                  return "Passwords are not matchting";
                }
                return null;
              }),
        ),
      );

// current location button
  Widget get getCurrentLocation => Obx(() {
        if (controller.locationLoader.value) {
          return const CircularProgressIndicator();
        } else {
          return GestureDetector(
            onTap: () {
              GoogleServices.getCurrentPosition();
            },
            child: CommonOutlineBox(
              text: "Current Location",
              color: AppColor.primary,
            ),
          );
        }
      });

// opening time
  Widget get opeingTimeField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: GestureDetector(
          onTap: () {},
          child: CommonTextField(
            controller: controller.openingTime,
            hint: "Restaurant Open Time",
            prefixicon: Icons.timer,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "City is required";
              }
              return null;
            },
            onTap: () async {
              controller.openingTime.text =
                  await controller.timePicker(context) ?? "";
            },
          ),
        ),
      );

// closing time
  Widget get closingTimeField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.closingTime,
          hint: "Restaurant Close Time",
          prefixicon: Icons.timer,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "City is required";
            }
            return null;
          },
          onTap: () async {
            controller.closingTime.text =
                await controller.timePicker(context) ?? "";
          },
        ),
      );

  // restaurant full address text field
  Widget get fullAddressField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.fulladdresscontroller,
          hint: "Enter full address",
          prefixicon: Icons.location_history,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Full address is required";
            }
            return null;
          },
        ),
      );

  // restaurant full address text field
  Widget get stateField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.statecontroller,
          hint: "Enter State",
          prefixicon: Icons.location_city,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "State is required";
            }
            return null;
          },
        ),
      );

  // restaurant city text field
  Widget get cityField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.citycontroller,
          hint: "Enter City",
          prefixicon: Icons.location_city,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "City is required";
            }
            return null;
          },
        ),
      );

  // restaurant zipcode text field
  Widget get zipcodeField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.zipcontroller,
          hint: "Enter Zipcode",
          prefixicon: Icons.location_on_sharp,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Zipcode is required";
            }
            return null;
          },
        ),
      );

  // contact email text field
  Widget get contactmailField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.resContactMail,
          hint: "Enter Email",
          prefixicon: Icons.email,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email is required";
            }
            return null;
          },
        ),
      );

  // contact phn text field
  Widget get contactPhnField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: CommonTextField(
          controller: controller.resContactPhn,
          hint: "Enter Phone Number",
          prefixicon: Icons.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Phone is required";
            }
            return null;
          },
        ),
      );

// select food type
  Widget get selectFoodType => Column(
        children: List.generate(
          3,
          (index) => foodSelector(text: controller.foodType[index]),
        ),
      );

// food selector box
  Widget foodSelector({required String text}) => GestureDetector(
        onTap: () {
          setState(() {
            controller.selectedFood.value = text;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(
                color: controller.selectedFood.value == text
                    ? AppColor.primary
                    : AppColor.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: controller.selectedFood.value == text
                      ? AppColor.primary
                      : AppColor.grey,
                ),
              ),
              Radio(
                value: text,
                groupValue: controller.selectedFood.value,
                onChanged: (value) {
                  setState(() {
                    controller.selectedFood.value = value.toString();
                    dev.log(controller.selectedFood.value);
                  });
                },
              ),
            ],
          ),
        ),
      );

// restuarant open days
  Widget get restuarantOpendays => SizedBox(
        width: Get.width,
        height: 30,
        child: ListView.separated(
          padding: const EdgeInsets.only(left: 15, right: 15),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 10,
          ),
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            return weekDaysTile(index: index);
          },
        ),
      );

  // week days tile
  Widget weekDaysTile({required int index}) => GestureDetector(
        onTap: () {
          if (controller.selectedDays.contains(controller.weekDays[index])) {
            dev.log("Already exists");
            controller.selectedDays.remove(controller.weekDays[index]);
          } else {
            controller.selectedDays.add(controller.weekDays[index]);
          }

          dev.log(controller.selectedDays.toString());
        },
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: controller.selectedDays
                          .contains(controller.weekDays[index])
                      ? AppColor.primary
                      : AppColor.grey),
            ),
            child: CommonSubTtile(
              titleText: controller.weekDays[index],
              color:
                  controller.selectedDays.contains(controller.weekDays[index])
                      ? AppColor.primary
                      : AppColor.black,
            ),
          ),
        ),
      );
}
