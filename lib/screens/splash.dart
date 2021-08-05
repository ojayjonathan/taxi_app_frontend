import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  @override
  void afterFirstLayout(BuildContext context) => initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Mat'ndogo".toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 40),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Future initializeApp() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String _authToken = _prefs.get("authToken");
    bool _seen = _prefs.getBool("seen") ?? false;
    _prefs.remove("travelRoutes");
    //inialize app data
    if (_seen) {
      if (_authToken == null) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    } else {
      _prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed(AppRoutes.introduction);
    }
  }
}
