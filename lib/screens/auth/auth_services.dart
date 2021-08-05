import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/exception.dart';
import 'package:taxi_app/serializers.dart';

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
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("authToken", response.data['token']);
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<String> getAuthToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("authToken");
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      String authToken = _prefs.getString("authToken");
      var _profile = await dio.put("${ipAddress}api/customer/profile/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout),
          data: data);
      print(_profile.data);
      _prefs.setString("user", jsonEncode(_profile.data));
      return User.fromJson(_profile.data as Map);
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<void> uploadProfileIMage() async {}
  static Future<Map<String, dynamic>> resetPassword({Map data}) async {
    try {
      final res = await dio.post("${ipAddress}api/auth/reset/", data: data);
      return res.data as Map;
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<Map<String, dynamic>> setNewPassword({Map data}) async {
    try {
      final res = await dio.put("${ipAddress}api/auth/reset/",
          data: data, options: Options(sendTimeout: timeout));
      return res.data as Map;
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<User> getUserProfile() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _userData = _prefs.get("user");
    if (_userData != null) {
      return User.fromJson(jsonDecode(_userData));
    } else {
      try {
        String authToken = _prefs.getString("authToken");
        var profile = await dio.get("${ipAddress}api/customer/profile/",
            options: Options(
                headers: {'Authorization': 'Token $authToken'},
                sendTimeout: timeout));
        _prefs.setString("user", jsonEncode(profile.data));
        return User.fromJson(profile.data as Map);
      } catch (e) {
        throw getException(e);
      }
    }
  }
}
