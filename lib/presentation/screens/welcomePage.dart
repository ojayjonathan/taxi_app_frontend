import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/presentation/widgets/paints/welcomePagePaint.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _signUpButton() {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.signup),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(999),
          ),
          border: Border.all(color: Palette.primary3Color, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(
              color: Palette.dark[1],
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "let's ride",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          "Mat'ndogo",
          style: TextStyle(
              color: Palette.dark[0],
              fontWeight: FontWeight.w500,
              fontSize: 28),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: height * 0.6,
                    child: WelcomePagePaint(),
                  ),
                  Container(
                    height: height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: _title(),
                          width: width * 0.75,
                          padding: EdgeInsets.only(top: 50),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SvgPicture.asset(
                            "assets/graphics/taxi.svg",
                            width: width * 0.75,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: submitButton(
                    context,
                    () => Navigator.of(context).pushNamed(AppRoutes.login),
                    "Login",
                    fontSize: 18,
                    borderRadius: 999),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: _signUpButton(),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
