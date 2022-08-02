import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/data/providers/auth.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

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
              "MAT'NDOGO",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }

  initializeApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString("authToken");
    bool seen = prefs.getBool("seen") ?? false;
    if (seen && mounted) {
      if (authToken == null) {
        context.goNamed(AppRoutes.welcome);
      } else {
        context.read<AuthProvider>().login(authToken);
      }
    } else {
      prefs.setBool('seen', true);
      context.goNamed(AppRoutes.introduction);
    }
  }
}
