import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/data/auth_services.dart';
import 'package:taxi_app/data/exception.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/presentation/widgets/entry_field.dart';
import 'package:taxi_app/presentation/widgets/paints/bezierContainer.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:taxi_app/resources/utils/validators.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, String? title}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  String? _registartionToken;
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
    if (formKey.currentState?.validate() == true && !_submiting && isChecked) {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            duration: const Duration(milliseconds: 10000),
          ),
        );
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Have an account ?",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
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
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _title(),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            entryField(
                              "Email",
                              controller: _email,
                              icon: Icons.email,
                              hintText: "john@gmail.com",
                              validator: emailValidator,
                            ),
                            entryField(
                              "First Name",
                              controller: _firstName,
                              validator: requiredValidator,
                              icon: Icons.person,
                              hintText: "john",
                            ),
                            entryField(
                              "Last Name",
                              controller: _lastName,
                              validator: requiredValidator,
                              icon: Icons.person,
                              hintText: "doe",
                            ),
                            phoneEntryField(
                              "Phone number",
                              validator: phoneValidator,
                              controller: _phoneNumber,
                            ),
                            PasswordField(_password)
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked,
                          onChanged: (bool? value) {
                            if (value == null) return;
                            setState(() {
                              isChecked = value;
                            });
                          },
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context)
                              .popAndPushNamed(AppRoutes.terms),
                          child: Text(
                            'Accept  ',
                            style: TextStyle(
                                color: Palette.dark[2],
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Text("terms and conditions to continue.")
                      ],
                    ),
                    Text(
                      errorText,
                      style: TextStyle(
                          color: Theme.of(context).errorColor, fontSize: 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    submitButton(context, _sumitForm, "Register"),
                    _loginLabel(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: Hero(
              tag: "page_paint",
              child: BezierContainer(),
            ),
          ),
        ],
      ),
    );
  }
}
