import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/screens/auth/services/auth_services.dart';
import 'package:taxi_app/widgets/buttons.dart';
import "package:taxi_app/widgets/entry_field.dart";
import 'package:taxi_app/widgets/paints/bezierContainer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/screens/auth/loginPage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  void _sumitForm() async {
    if (formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Submiting please wait...",
        style: TextStyle(color: Palette.successColor),
      )));
      try {
        await UserAuthentication().registerUser(jsonEncode({
          "email": _email.text,
          "password": _password.text,
          "first_name": _firstName.text,
          "last_name": _lastName.text,
          "phone_number": "+254${_phoneNumber.text}",
        }));
        //if registration was successful

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Registration was sucessfull",
          style: TextStyle(color: Palette.successColor),
        )));
        // push the user to login page
        Navigator.of(context).pushNamed(AppRoutes.login);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.response.toString(),
          style: TextStyle(color: Theme.of(context).errorColor),
        )));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _password.dispose();
    _phoneNumber.dispose();
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'mat',
          style: TextStyle(color: Palette.headerColor, fontSize: 30),
        ),
        TextSpan(
          text: 'ndogo',
          style: TextStyle(color: Palette.accentColor, fontSize: 30),
        ),
      ]),
    );
  }

  Widget _loginLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Have an account ?",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => Navigator.of(context).popAndPushNamed(AppRoutes.login),
            child: Text(
              'Login',
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(top: 0, right: 0, child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _title(),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            entryField("Email",
                                controller: _email,
                                icon: Icons.email,
                                hintText: "john@gmail.com",
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "Required"),
                                  EmailValidator(
                                      errorText: "Please provide a valid email")
                                ])),
                            entryField("First Name",
                                controller: _firstName,
                                validator:
                                    RequiredValidator(errorText: "Required"),
                                icon: Icons.person,
                                hintText: "john"),
                            entryField("Last Name",
                                controller: _lastName,
                                validator:
                                    RequiredValidator(errorText: "Required"),
                                icon: Icons.person,
                                hintText: "doe"),
                            phoneEntryField("Phone number",
                                validator:
                                    RequiredValidator(errorText: "Required"),
                                controller: _phoneNumber),
                            entryField("Password",
                                controller: _password,
                                validator: passwordValidator,
                                isPassword: true,
                                icon: Icons.lock,
                                hintText: "password")
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    submitButton(context, _sumitForm, "Register"),
                    _loginLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String phoneValidator(value) {
  if (value.isEmpty) {
    return "Required";
  } else if (value.length != 9) {
    return "Please provide valid phone number";
  } else {
    return null;
  }
}
