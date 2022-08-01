import 'package:shared_preferences/shared_preferences.dart';

class UserAuthentication {
  static Future<String> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("authToken") ?? "";
  }
}
