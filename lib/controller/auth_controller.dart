// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fideos_web/presentation/home_screen.dart';
import 'package:fideos_web/services/google_services.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../common/common_flash_msg.dart';

import '../presentation/auth/login.dart';
import '../services/api_services.dart';
import '../services/auth_services.dart';
import '../services/cookie.dart';
import '../services/endpoints.dart';

class AuthController extends GetxController {
  // controllers for login
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

// login loader
  RxBool loginLoader = false.obs;
  RxBool registerLoader = false.obs;

  // location loader
  RxBool locationLoader = false.obs;

// controllers for registration
  TextEditingController regemailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController regpasswordcontroller = TextEditingController();
  TextEditingController regconfirmpasswordcontroller = TextEditingController();

// controllers for location
  TextEditingController fulladdresscontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController zipcontroller = TextEditingController();

// controllers for restaurant timming
  TextEditingController openingTime = TextEditingController();
  TextEditingController closingTime = TextEditingController();

  // controllers for restaurant Contact
  TextEditingController resContactMail = TextEditingController();
  TextEditingController resContactPhn = TextEditingController();

// dinning available
  RxBool dinning = false.obs;

  // delivery available
  RxBool delivery = false.obs;

  // obsecure for login
  RxBool obsecure = false.obs;

// obsecure for register
  RxBool regobsecure1 = false.obs;
  RxBool regobsecure2 = false.obs;

  // change obsecurity for login
  void get changeobsecure => obsecure.value = !obsecure.value;

  // change obsecurity for registration
  void get changeobsecurereg1 => regobsecure1.value = !regobsecure1.value;
  void get changeobsecurereg2 => regobsecure2.value = !regobsecure2.value;

  // food type
  List foodType = ["Veg", "Non Veg", "Both"];
  Rx<String> selectedFood = "Veg".obs;

  // restuarant open days
  List weekDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Satureday"
  ];
  RxList selectedDays = [].obs;

// serving foods dynamic form list
  final RxList<Map<String, Object>> dataArray = [
    {'value': '', 'id': 0}
  ].obs;
  final RxList servingFoodList = [].obs;
  final RxList<TextEditingController> controllers =
      [TextEditingController()].obs;

  // updating dynamic feild value
  void onUpdate(int key, String val) {
    dataArray[key]['value'] = val;
    servingFoodList.clear();
    for (var item in dataArray) {
      servingFoodList.add(item['value'].toString());
      servingFoodList.refresh();
    }
    log("Extra List: $servingFoodList");
  }

// add more  text feild
  void get addMore {
    final newKey = dataArray.length;
    dataArray.add({'value': '', 'id': newKey});
    controllers.add(TextEditingController());
    dataArray.refresh();
    controllers.refresh();
  }

// remove text field
  void removeField(int key) {
    dataArray.removeAt(key);
    controllers.removeAt(key);
    dataArray.refresh();
    controllers.refresh();
  }

  // list of restaurant images
  final RxList selectedImages = [].obs;

// image picker
  Future<void> get pickImage async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImages.add(File(pickedFile.path));
      selectedImages.refresh();
      log(selectedImages.toString());
    }
  }

  // time picker
  TimeOfDay? selectedTime;
  TimeOfDay? resClosingTime;
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;

  // time picker function
  Future<String?> timePicker(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      initialEntryMode: entryMode,
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: child!,
          ),
        );
      },
    );

    final formatTime = time!.format(context);
    log(formatTime);
    return formatTime;
  }

  // login
  get login async {
    /* login button starts loading */
    loginLoader.value = true;
    // separating customer provided email and password
    final email = emailcontroller.text.trim().toLowerCase();
    final password = passwordcontroller.text.trim();
    // Preparing request body
    final body = {"email": email, "password": password};
    try {
      // calling login api
      final response = await AuthServices.login(body: body);

      if (response.isNotEmpty) {
        // fetching error status
        CookieService.saveCookie(key: 'token', value: response["token"]);
        // Checking user
        final restaurant = response["restaurant"];
        log("message=> $response");

        if (restaurant != null) {
          // When user is not null
          log(restaurant.toString());
          // Convert into model and all
          CookieService.saveCookie(
              key: 'user', value: response["restaurant"].toString());
          FlashMessage.show(
              title: "Successful",
              message: "Successfully Login",
              isSuccess: true);
        }
        /* navigating to the base screen */
        Get.to(() => HomeScreen());
      } else {
        // invalid credentials
        final message = response["message"];
        FlashMessage.show(
            title: message.toString(),
            message: "Please try again",
            isError: true);
      }
    } catch (e) {
      return FlashMessage.show(title: e.toString(), isError: true);
    }
    /* login button ends loading */
    loginLoader.value = false;
  }

  // Registration API
  void get register async {
    // start loader
    registerLoader.value = true;
    // res name
    final name = namecontroller.text.trim();
    // contact mail
    final contactMail = resContactMail.text.trim();
    // contact phn
    final contactPhn = resContactPhn.text.trim();
    // opening time
    final openTime = openingTime.text.trim();
    // close time
    final closeTime = closingTime.text.trim();
    //  email
    final email = regemailcontroller.text.trim();
    //  password
    final password = regpasswordcontroller.text.trim();
    // food type
    final foodType = selectedFood;

    // Preparing request body
    var body = {
      "name": name.toString(),
      "email": email.toString(),
      "password": password.toString(),
      "servings": servingFoodList,
      "timings": {
        "openTime": openTime.toString(),
        "closeTime": closeTime.toString(),
        "openWeekDays": selectedDays
      },
      "isDeliveryAvailable": delivery.value,
      "isDineInAvailable": dinning.value,
      "contact": {
        "email": contactMail.toString(),
        "phone": contactPhn.toString(),
      },
      "isVeg":
          foodType.value == "Veg" || foodType.value == "Both" ? true : false,
      "isNonVeg": foodType.value == "Non Veg" || foodType.value == "Both"
          ? true
          : false,
      "address": {
        "coOrdinate": {
          "latitude": GoogleServices.currentPosition!.latitude.toString(),
          "longitude": GoogleServices.currentPosition!.longitude.toString()
        },
        "fullAddress": fulladdresscontroller.text.toString(),
        "state": statecontroller.text.toString(),
        "city": citycontroller.text.toString(),
        "zipCode": zipcontroller.text.toString()
      }
    };

    try {
      // Calling user register API to get user details
      final response = await AuthServices.registration(body: body);
      if (response.isNotEmpty) {
        final token = response["token"].toString();

        // saving token in cookie
        CookieService.saveCookie(key: 'token', value: token);

        log("Token==xx> ${CookieService.getCookie(key: "token")}");

        // Checking user
        final restaurant = response["restaurant"];
        if (restaurant != null) {
          // When user is not null
          log(restaurant.toString());
          // Convert into model and all
          CookieService.saveCookie(
              key: 'user', value: response["restaurant"].toString());
          FlashMessage.show(
              title: "Successful",
              message: response["message"].toString(),
              isSuccess: true);
          // redirect to login page
          Get.to(() => const LoginScreen());
        }
      }
      namecontroller.clear();
      regconfirmpasswordcontroller.clear();
      closingTime.clear();
      openingTime.clear();
      regemailcontroller.clear();
      regpasswordcontroller.clear();
      statecontroller.clear();
      citycontroller.clear();
      zipcontroller.clear();
      fulladdresscontroller.clear();
      selectedDays.clear();
      servingFoodList.clear();
      resContactMail.clear();
      resContactPhn.clear();
    } catch (e) {
      // When some error occurs
    }
    // end loader
    registerLoader.value = false;
  }
}
