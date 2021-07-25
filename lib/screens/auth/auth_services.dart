import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/serializers.dart';

Duration reqTimeout = Duration(microseconds: 10000);

class UserAuthentication {
  static Future<void> loginUser(Map data) async {
    try {
      final response =
          await Dio().post("${ipAddress}api/auth/login/", data: data);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("authToken", response.data['token']);
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  static Future<String> getAuthToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("authToken");
  }

  static Future<void> registerUser(String data) async {
    try {
      await Dio().post("${ipAddress}api/auth/customer/register/", data: data);
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(
          requestOptions: null,
          response: e.response.data["errors"] ?? e.message);
    }
  }

  static Future<User> updateProfile(String data) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      String authToken = _prefs.getString("authToken");
      var _profile = await Dio().put("${ipAddress}api/customer/profile/",
          options: Options(headers: {'Authorization': 'Token $authToken'}));
      _prefs.setString("user", jsonEncode(_profile.data));
      return User.fromJson(_profile.data as Map);
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  static Future<void> uploadProfileIMage() async {}
  static Future<Map<String, dynamic>> resetPassword({Map data}) async {
    try {
      final res = await Dio().post("${ipAddress}api/auth/reset/", data: data);
      return res.data as Map;
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  static Future<Map<String, dynamic>> setNewPassword({Map data}) async {
    try {
      final res = await Dio().put("${ipAddress}api/auth/reset/", data: data);
      return res.data as Map;
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
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
        var profile = await Dio().get("${ipAddress}api/customer/profile/",
            options: Options(headers: {'Authorization': 'Token $authToken'}));
        _prefs.setString("user", jsonEncode(profile.data));
        return User.fromJson(profile.data as Map);
      } on SocketException catch (e) {
        throw SocketException(e.message.toString());
      } on DioError catch (e) {
        throw DioError(requestOptions: null, response: e.response ?? e.message);
      }
    }
  }
}
