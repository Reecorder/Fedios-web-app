import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../common/common_flash_msg.dart';
import 'cookie.dart';

class ApiService {
// dio base options//
  static BaseOptions get baseOptions => BaseOptions(
        baseUrl: "https://fideos-node.vercel.app",
        headers: {
          "Content-Type": "application/json",
        },
      );

// instance of dio
  static Dio dio = Dio(baseOptions);

  // GET Request
  static Future<Map<String, dynamic>> get(
      {required String endpoint, bool header = true}) async {
    // auth token
    final token = await CookieService.getCookie(key: 'token');
    try {
      final response = await dio.get(
        endpoint,
        options: Options(
          headers: header
              ? {
                  'Authorization': 'Bearer $token',
                }
              : {},
        ),
      );

      return response.data;
    } catch (error) {
      log(error.toString());
      FlashMessage.show(
          title: error.toString(),
          message: "Please try again later",
          isError: true);
      return {};
    }
  }

  // POST Request
  static Future<Map<String, dynamic>> post(
      {required String endpoint,
      required Map<String, dynamic> data,
      bool header = true}) async {
    // auth token
    final token = await CookieService.getCookie(key: 'token');
    try {
      debugPrint("token==> $token");
      log("Url=> $endpoint");
      log("request body=> $data");
      final response = await dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: header
              ? {
                  'Authorization': 'Bearer $token',
                }
              : {},
        ),
      );
      return response.data;
    } catch (error) {
      log(error.toString());
      FlashMessage.show(
          title: error.toString(),
          message: "Please try again later",
          isError: true);
      return {};
    }
  }

  // PUT Request
  static Future<Map<String, dynamic>> put(
      {required String endpoint,
      required Map<String, dynamic> data,
      bool header = true}) async {
    // auth token
    final token = await CookieService.getCookie(key: 'token');
    try {
      final response = await dio.put(
        endpoint,
        data: data,
        options: Options(
          headers: header
              ? {
                  'Authorization': 'Bearer $token',
                }
              : {},
        ),
      );
      return response.data;
    } catch (error) {
      log(error.toString());
      FlashMessage.show(
          title: error.toString(),
          message: "Please try again later",
          isError: true);
      return {};
    }
  }
}
