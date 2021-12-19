import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/exception.dart';
import 'package:taxi_app/screens/auth/auth_services.dart';
import 'package:taxi_app/utils/validators.dart';

import 'package:taxi_app/widgets/buttons.dart';
import "package:taxi_app/widgets/entry_field.dart";
import 'package:taxi_app/widgets/paints/bezierContainer.dart';
import 'package:taxi_app/palette.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  //will be used for push notification
  String _registartionToken;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      _registartionToken = value;
    });
  }

  bool _submiting = false;
  void validateForm() async {
    if (formkey.currentState.validate() && !_submiting) {
      ScaffoldMessenger.of(context).clearSnackBars();
      _submiting = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Submiting please wait...',
          style: TextStyle(color: Palette.successColor),
        ),
        duration: Duration(milliseconds: 10000),
      ));
      try {
        await UserAuthentication.loginUser({
          "email": _email.text.trim(),
          "password": _password.text,
          "registration_id": _registartionToken
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login was sucessfull",
                style: TextStyle(color: Palette.successColor))));
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } on Failure catch (e) {
        _submiting = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.message,
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          duration: Duration(seconds: 60),
        ));
      }
    }
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          SizedBox(width: 10),
          InkWell(
            onTap: () =>
                Navigator.of(context).popAndPushNamed(AppRoutes.signup),
            child: Text('Register',
                style: TextStyle(
                    color: Palette.primary3Color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Mat',
          style: TextStyle(color: Palette.textColor, fontSize: 30),
        ),
        TextSpan(
          text: 'ndogo',
          style: TextStyle(color: Palette.accentColor, fontSize: 30),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Center(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _title(),
                    SizedBox(height: 10),
                    Form(
                      key: formkey,
                      child: Column(children: <Widget>[
                        entryField("Email",
                            controller: _email,
                            icon: Icons.email,
                            hintText: "john@gmail.com",
                            validator: emailValidator,
                            keyboardType: TextInputType.emailAddress),
                        PasswordField(_password)
                      ]),
                    ),
                    SizedBox(height: 10),
                    submitButton(context, validateForm, "Login"),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.resetPassword),
                        child: Text('Forgot Password ?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Hero(tag: "page_paint", child: BezierContainer())),
        ],
      ),
    ));
  }
}
