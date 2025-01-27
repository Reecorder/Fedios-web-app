import 'dart:developer';

import 'package:fideos_web/common/common_flash_msg.dart';
import 'package:fideos_web/controller/auth_controller.dart';
import 'package:fideos_web/services/auth_services.dart';
import 'package:fideos_web/services/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GoogleServices {
  static final controller = Get.put(AuthController());

  // current position
  static Position? currentPosition;

  // get current position for location
  static Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      FlashMessage.show(
          title: "Falied",
          message:
              'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        FlashMessage.show(
            title: "Failed", message: "Location permission denied");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      FlashMessage.show(
          title: "Failed",
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

// get  current user location
  static Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      // seding lat long for address convertion
      getAddressFromCoordinates(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

// convert lat long to address
  static void getAddressFromCoordinates(
      double latitude, double longitude) async {
    // loader start
    controller.locationLoader.value = true;
    // body for address convertion
    final body = {"latitude": latitude, "longitude": longitude};
    // Preparing endpoint
    final endpoint = Endpoints.authentication + Endpoints.currentLocation;
    try {
      // calling location api
      final response =
          await AuthServices.currentLocation(body: body, endpoint: endpoint);
      if (response.containsKey("display_name")) {
        // Checking response
        final location = response["address"];
        log("response=> $location");
        if (location != null) {
          // assigning value to controller
          controller.fulladdresscontroller.text =
              "${location["suburb"]},${location["city"]}";
          controller.citycontroller.text =
              location["state_district"].toString();
          controller.statecontroller.text = location["state"].toString();
          controller.zipcontroller.text = location["postcode"].toString();

          // When location is not null
          FlashMessage.show(
              title: "Successful",
              message: "Location Fetched",
              isSuccess: true);
        }
      } else {
        FlashMessage.show(
            title: "Failed",
            message: "Current location is not valid. Please enter manually",
            isError: true);
      }
    } catch (e) {
      FlashMessage.show(title: e.toString(), isError: true);
    }
    /* ends loading */
    controller.locationLoader.value = false;
  }
}
