import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/exception.dart';
import 'package:taxi_app/screens/auth/auth_services.dart';
import 'package:taxi_app/utils/validators.dart';
import 'package:taxi_app/widgets/buttons.dart';
import "package:taxi_app/widgets/entry_field.dart";
import 'package:taxi_app/widgets/paints/bezierContainer.dart';
import 'package:taxi_app/palette.dart';

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
  String _registartionToken;
  bool _submiting = false;
  bool isChecked = false;
  String errorText = "";
  @override
  void initState() {
    super.initState();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      _registartionToken = value;
    });
  }

  void _sumitForm() async {
    if (!isChecked) {
      errorText = "Agree with terms and conditions.";
    } else {
      errorText = "";
    }
    if (formKey.currentState.validate() && !_submiting && isChecked) {
      ScaffoldMessenger.of(context).clearSnackBars();
      _submiting = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Submiting please wait...",
              style: TextStyle(color: Palette.successColor))));
      try {
        await UserAuthentication.registerUser(jsonEncode({
          "email": _email.text,
          "password": _password.text,
          "first_name": _firstName.text,
          "last_name": _lastName.text,
          "phone_number": "+254${_phoneNumber.text.substring(1)}",
          "registration_id": _registartionToken
        }));
        //if registration was successful
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Registration was sucessfull",
                style: TextStyle(color: Palette.successColor))));
        // push the user to login page
        Navigator.of(context).pushNamed(AppRoutes.login);
      } on Failure catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              e.message,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            duration: Duration(milliseconds: 10000)));
      }
    }
    _submiting = false;
    setState(() {});
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
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
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
                                  validator: emailValidator),
                              entryField("First Name",
                                  controller: _firstName,
                                  validator: requiredValidator,
                                  icon: Icons.person,
                                  hintText: "john"),
                              entryField("Last Name",
                                  controller: _lastName,
                                  validator: requiredValidator,
                                  icon: Icons.person,
                                  hintText: "doe"),
                              phoneEntryField("Phone number",
                                  validator: phoneValidator,
                                  controller: _phoneNumber),
                              PasswordField(_password)
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (bool value) {
                              setState(() {
                                isChecked = value;
                              });
                            },
                          ),
                          InkWell(
                              onTap: () => Navigator.of(context)
                                  .popAndPushNamed(AppRoutes.terms),
                              child: Text('Accept  ',
                                  style: TextStyle(
                                      color: Palette.dark[2],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600))),
                          Text("terms and conditions to continue.")
                        ],
                      ),
                      Text(errorText,
                          style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 10)),
                      SizedBox(
                        height: 10,
                      ),
                      submitButton(context, _sumitForm, "Register"),
                      _loginLabel(),
                      SizedBox(
                        height: 10,
                      ),
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
      ),
    );
  }
}
