import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/serializers.dart';

Duration reqTimeout = Duration(microseconds: 10000);

class UserAuthentication {
  Future<void> loginUser(Map data) async {
    try {
      final response =
          await Dio().post("${ipAddress}api/auth/login/", data: data);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("authToken", response.data['token']);
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  Future<String> getAuthToken(String authToken) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("authToken");
  }

  Future<void> registerUser(String data) async {
    try {
      await Dio().post("${ipAddress}api/auth/customer/register/", data: data);
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  Future<User> updateProfile(String data) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      String authToken = _prefs.getString("authToken");
      var _profile = await Dio().put("${ipAddress}api/customer/profile/",
          options: Options(headers: {'Authorization': 'Token $authToken'}));
      _prefs.setString("user", jsonEncode(_profile.data));
      return User.fromJson(_profile.data as Map);
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  Future<void> uploadProfileIMage() async {}
  Future<User> getUserProfile() async {
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
      } on DioError catch (e) {
        throw DioError(requestOptions: null, response: e.response ?? e.message);
      }
    }
  }
}
