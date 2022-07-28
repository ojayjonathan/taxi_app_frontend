import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/data/exception.dart';
import 'package:taxi_app/data/models.dart';
import 'package:taxi_app/resources/constants.dart';

class UserAuthentication {
  static Dio dio =
      Dio(BaseOptions(connectTimeout: timeout, receiveTimeout: timeout));
  static Future<void> loginUser(Map data) async {
    try {
      final response = await dio.post(
        "${ipAddress}api/auth/login/",
        data: data,
        options: Options(sendTimeout: timeout),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
        "authToken",
        response.data['token'],
      );
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<String> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("authToken") ?? "";
  }

  static Future<void> registerUser(String data) async {
    try {
      await dio.post("${ipAddress}api/auth/customer/register/",
          data: data, options: Options(sendTimeout: timeout));
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<User> updateProfile(String data) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String? authToken = prefs.getString("authToken");
      var profile = await dio.put("${ipAddress}api/customer/profile/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout),
          data: data);
      print(profile.data);
      prefs.setString("user", jsonEncode(profile.data));
      return User.fromJson(profile.data);
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<void> uploadProfileIMage() async {}
  static Future<Map<String, dynamic>> resetPassword({required Map data}) async {
    try {
      final res = await dio.post("${ipAddress}api/auth/reset/", data: data);
      return res.data;
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<Map<String, dynamic>> setNewPassword(
      {required Map data}) async {
    try {
      final res = await dio.put(
        "${ipAddress}api/auth/reset/",
        data: data,
        options: Options(sendTimeout: timeout),
      );
      return res.data;
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<User> refreshUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String? authToken = prefs.getString("authToken");
      var profile = await dio.get(
        "${ipAddress}api/customer/profile/",
        options: Options(
            headers: {'Authorization': 'Token $authToken'},
            sendTimeout: timeout),
      );
      prefs.setString(
        "user",
        jsonEncode(profile.data),
      );
      return User.fromJson(profile.data);
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<User> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString("user");
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    } else {
      try {
        String? authToken = prefs.getString("authToken");
        var profile = await dio.get(
          "${ipAddress}api/customer/profile/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout),
        );
        prefs.setString(
          "user",
          jsonEncode(profile.data),
        );
        return User.fromJson(profile.data);
      } catch (e) {
        throw getException(e);
      }
    }
  }
}
