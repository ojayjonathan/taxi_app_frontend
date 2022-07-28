import 'package:flutter/material.dart';
import 'package:taxi_app/presentation/screens/auth/loginPage.dart';
import 'package:taxi_app/presentation/screens/auth/resetPassword.dart';
import 'package:taxi_app/presentation/screens/auth/signup.dart';
import 'package:taxi_app/presentation/screens/book.dart';
import 'package:taxi_app/presentation/screens/intro.dart';
import 'package:taxi_app/presentation/screens/makeBooking.dart';
import 'package:taxi_app/presentation/screens/noConnection.dart';
import 'package:taxi_app/presentation/screens/splash.dart';
import 'package:taxi_app/presentation/screens/support.dart';
import 'package:taxi_app/presentation/screens/userAccount/UserAccount.dart';
import 'package:taxi_app/presentation/screens/userAccount/feedback.dart';
import 'package:taxi_app/presentation/screens/userAccount/terms.dart';
import 'package:taxi_app/presentation/screens/userAccount/userBookHistory.dart';
import 'package:taxi_app/presentation/screens/welcomePage.dart';
import 'package:taxi_app/resources/constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
    case AppRoutes.home:
      return MaterialPageRoute(
        builder: (context) => Booking(),
      );
    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (context) => LoginPage(),
      );
    case AppRoutes.signup:
      return MaterialPageRoute(
        builder: (context) => SignUpPage(),
      );
    case AppRoutes.account:
      return MaterialPageRoute(
        builder: (context) => AccountPage(),
      );
    case AppRoutes.bookHistory:
      return MaterialPageRoute(
        builder: (context) => BookHistory(),
      );
    case AppRoutes.resetPassword:
      return MaterialPageRoute(
        builder: (context) => ResetPasswordPage(),
      );
    case AppRoutes.feedback:
      return MaterialPageRoute(
        builder: (context) => UserFeedBack(),
      );
    case AppRoutes.welcome:
      return MaterialPageRoute(
        builder: (context) => WelcomePage(),
      );
    case AppRoutes.makeBooking:
      final args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) =>
            BookConfirm(selectedRoute: args as Map<String, dynamic>),
      );
    case AppRoutes.support:
      return MaterialPageRoute(
        builder: (context) => ContactUs(),
      );
    case AppRoutes.introduction:
      return MaterialPageRoute(
        builder: (context) => OnBoardingPage(),
      );
    case AppRoutes.connectionError:
      return MaterialPageRoute(
        builder: (context) => NoConnection(),
      );
    case AppRoutes.terms:
      return MaterialPageRoute(
        builder: (context) => Terms(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => WelcomePage(),
      );
  }
}
