import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/screens/auth/loginPage.dart';
import 'package:taxi_app/screens/auth/resetPassword.dart';
import 'package:taxi_app/screens/auth/signup.dart';
import 'package:taxi_app/screens/book.dart';
import 'package:taxi_app/screens/makeBooking.dart';
import 'package:taxi_app/screens/UserAccount.dart';
import 'package:taxi_app/screens/intro.dart';
import 'package:taxi_app/screens/splash.dart';
import 'package:taxi_app/screens/support.dart';
import 'package:taxi_app/screens/welcomePage.dart';

import 'screens/userAccount/feedback.dart';
import 'screens/userAccount/userBookHistory.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (context) => Booking());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case AppRoutes.account:
      return MaterialPageRoute(builder: (context) => AccountPage());
    case AppRoutes.bookHistory:
      return MaterialPageRoute(builder: (context) => BookHistory());
    case AppRoutes.resetPassword:
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
    case AppRoutes.feedback:
      return MaterialPageRoute(builder: (context) => UserFeedBack());
    case AppRoutes.welcome:
      return MaterialPageRoute(builder: (context) => WelcomePage());
    case AppRoutes.makeBooking:
      return MaterialPageRoute(builder: (context) => BookConfirm());
    case AppRoutes.support:
      return MaterialPageRoute(builder: (context) => ContactUs());
    case AppRoutes.introduction:
      return MaterialPageRoute(builder: (context) => OnBoardingPage());

    //TODO: return page not found
    default:
      return MaterialPageRoute(builder: (context) => WelcomePage());
  }
}
