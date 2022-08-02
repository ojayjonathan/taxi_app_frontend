import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/data/providers/auth.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/presentation/screens/auth/loginPage.dart';
import 'package:taxi_app/presentation/screens/auth/resetPassword.dart';
import 'package:taxi_app/presentation/screens/auth/signup.dart';
import 'package:taxi_app/presentation/screens/intro.dart';
import 'package:taxi_app/presentation/screens/makeBooking.dart';
import 'package:taxi_app/presentation/screens/splash.dart';
import 'package:taxi_app/presentation/screens/welcomePage.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:taxi_app/presentation/screens/book.dart';
import 'package:taxi_app/presentation/screens/support.dart';
import 'package:taxi_app/presentation/screens/userAccount/UserAccount.dart';
import 'package:taxi_app/presentation/screens/userAccount/feedback.dart';
import 'package:taxi_app/presentation/screens/userAccount/userBookHistory.dart';

class Matndogo extends StatefulWidget {
  const Matndogo({Key? key}) : super(key: key);

  @override
  State<Matndogo> createState() => _MatndogoState();
}

class _MatndogoState extends State<Matndogo> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Palette.primaryColor,
                playSound: true,
                icon: "@mipmap/launcher_icon",
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final GoRouter router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/",
      refreshListenable: GoRouterRefreshStream(authProvider.stream),
      redirect: (state) {
        String location = state.location;
        AuthStatus status = authProvider.status;
        //Redirect authenticated trying to access the app to login
        if (location.startsWith("/app") && status != AuthStatus.authenticated) {
          return AppRoutes.login;
        }

        //Redirect authenticated users to main page
        if (status == AuthStatus.authenticated &&
            !location.startsWith("/app")) {
          return AppRoutes.home;
        }

        return null;
      },
      routes: [
        GoRoute(
          name: AppRoutes.splash,
          path: "/",
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: AppRoutes.resetPassword,
          path: AppRoutes.resetPassword,
          builder: (context, state) => const ResetPasswordPage(),
        ),
        GoRoute(
          name: AppRoutes.introduction,
          path: AppRoutes.introduction,
          builder: (context, state) => const OnBoardingPage(),
        ),
        GoRoute(
          path: AppRoutes.welcome,
          name: AppRoutes.welcome,
          builder: (context, state) => WelcomePage(),
        ),
        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.signup,
          name: AppRoutes.signup,
          builder: (context, state) => const SignUpPage(),
        ),
        //------------------------------------------------------------//
        // User must be authenticted to access this pages
        //------------------------------------------------------------//
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.home,
          builder: (contex, state) => const Booking(),
          routes: [
            GoRoute(
              path: AppRoutes.account,
              name: AppRoutes.account,
              builder: (context, state) => const AccountPage(),
            ),
            GoRoute(
              path: AppRoutes.bookHistory,
              name: AppRoutes.bookHistory,
              builder: (context, state) => const BookHistory(),
            ),
            GoRoute(
              path: AppRoutes.feedback,
              name: AppRoutes.feedback,
              builder: (context, state) => const UserFeedBack(),
            ),
            GoRoute(
              path: AppRoutes.support,
              name: AppRoutes.support,
              builder: (context, state) => const ContactUs(),
            ),
            GoRoute(
              path: AppRoutes.makeBooking,
              name: AppRoutes.makeBooking,
              builder: (context, state) => BookConfirm(
                  selectedRoute: state.extra as Map<String, dynamic>),
            ),
          ],
        ),
        //-------------------------------------------------------//
        //-------------------------------------------------------//
      ],
    );
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: 'Mat\'ndogo',
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
        cardColor: Palette.backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
