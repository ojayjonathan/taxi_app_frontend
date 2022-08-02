import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/presentation/widgets/paints/welcome_page_paint.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _signUpButton() {
    return InkWell(
      onTap: () => context.goNamed(AppRoutes.signup),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
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
        const Text(
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
        child: SizedBox(
          height: height,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.6,
                    child: const WelcomePagePaint(),
                  ),
                  SizedBox(
                    height: height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: width * 0.75,
                          padding: const EdgeInsets.only(top: 50),
                          child: _title(),
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
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: submitButton(
                    context,
                    () => context.goNamed(AppRoutes.login),
                    "Login",
                    fontSize: 18,
                    borderRadius: 999),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: _signUpButton(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
