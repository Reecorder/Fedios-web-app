import 'dart:developer';

import 'package:fideos_web/services/api_services.dart';
import 'package:fideos_web/services/endpoints.dart';

import '../common/common_flash_msg.dart';

class AuthServices {
  // register customer
  static Future<Map<String, dynamic>> registration({body}) async {
    try {
      // Preparing endpoint
      final endpoint = Endpoints.authentication + Endpoints.registration;

      final response =
          await ApiService.post(endpoint: endpoint, data: body, header: false);
      return response;
    } catch (error) {
      FlashMessage.show(title: 'Error');
      return {};
    }
  }

  // login customer
  static Future<Map<String, dynamic>> login({body}) async {
    try {
      // Preparing endpoint
      final endpoint = Endpoints.authentication + Endpoints.login;

      final response =
          await ApiService.post(endpoint: endpoint, data: body, header: false);
      return response;
    } catch (error) {
      FlashMessage.show(title: 'Error');
      return {};
    }
  }

// google current location
  static Future<Map<String, dynamic>> currentLocation(
      {body, required String endpoint}) async {
    log("url=> $endpoint");
    try {
      final response =
          await ApiService.post(endpoint: endpoint, data: body, header: false);
      return response;
    } catch (error) {
      FlashMessage.show(title: 'Error');
      return {};
    }
  }
}
