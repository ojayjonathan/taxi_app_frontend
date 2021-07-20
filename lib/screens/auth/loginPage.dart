import 'package:flutter/material.dart';
import 'package:taxi_app/screens/auth/signup.dart';
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
  void validateForm() {
    if (formkey.currentState.validate()) {
      print("validate");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Submiting...')));
    } else {
      print("not valid");
    }
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
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
            Text(
              'Register',
              style: TextStyle(
                  color: Palette.primary3Color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
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
          //Color(0xffe46b10)
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
          Positioned(
              top: 0,
              right: 0,
              child: Hero(tag: "page_paint", child: BezierContainer())),
          Center(
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
                    child: Column(
                      children: <Widget>[
                        entryField("Email",
                            icon: Icons.email,
                            hintText: "john@gmail.com",
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Required'),
                              EmailValidator(
                                  errorText: 'Enter a valid email address')
                            ])),
                        entryField("Password",
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
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: backButton(context)),
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
