import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/screens/auth/auth_services.dart';
import 'package:taxi_app/widgets/buttons.dart';
import "package:taxi_app/widgets/entry_field.dart";
import 'package:taxi_app/widgets/paints/bezierContainer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:taxi_app/palette.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void validateForm() async {
    if (formkey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Submiting please wait...',
        style: TextStyle(color: Palette.successColor),
      )));
      try {
        await UserAuthentication.loginUser(
            {"email": _email.text, "password": _password.text});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Login was sucessfull",
          style: TextStyle(color: Palette.successColor),
        )));
        Navigator.of(context).popAndPushNamed(AppRoutes.home);
      } on SocketException {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Connection error ",
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.response.toString(),
          style: TextStyle(color: Theme.of(context).errorColor),
        )));
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
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () =>
                Navigator.of(context).popAndPushNamed(AppRoutes.signup),
            child: Text(
              'Register',
              style: TextStyle(
                  color: Palette.primary3Color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
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
          Positioned(top: 0, right: 0, child: BezierContainer()),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _title(),
                  SizedBox(height: 10),
                  Form(
                    key: formkey,
                    child: Column(
                      children: <Widget>[
                        entryField("Email",
                            controller: _email,
                            icon: Icons.email,
                            hintText: "john@gmail.com",
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Required'),
                              EmailValidator(
                                  errorText: 'Enter a valid email address')
                            ])),
                        entryField("Password",
                            controller: _password,
                            icon: Icons.lock,
                            hintText: "password",
                            validator: passwordValidator,
                            isPassword: true),
                      ],
                    ),
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
        ],
      ),
    ));
  }
}

String passwordValidator(value) {
  if (value.isEmpty) {
    return "Required";
  } else if (value.length < 6) {
    return "Should be atleast 6 characters";
  } else if (value.length > 15) {
    return "Should be atmost 15 characters";
  } else {
    return null;
  }
}
