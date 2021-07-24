import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:taxi_app/constants.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushNamed(AppRoutes.welcome);
  }



  Widget _buldSvg(String assetName) {
    return SvgPicture.asset(
      "assets/graphics/$assetName",
      width: 350,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: const Color(0xff212529)),
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        imagePadding: EdgeInsets.all(15),
        imageAlignment: Alignment.center,
        bodyAlignment: Alignment.center,
        bodyTextStyle: TextStyle(
          color: Color(0xff343a40),
        ));

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "page 1",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buldSvg("intro_p1.svg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "page 2",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buldSvg("intro_p2.svg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "page 3",
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buldSvg("intro_p3_.svg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "page 4",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buldSvg("intro_p3.svg"),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
