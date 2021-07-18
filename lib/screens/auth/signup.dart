import 'package:flutter/material.dart';
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
  void validateForm() {
    if (formKey.currentState.validate()) {
      print("form is valid");
    } else {
      print("invalid");
    }
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            entryField("Email",
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "Required"),
                                  EmailValidator(
                                      errorText: "Please provide a valid email")
                                ])),
                            phoneEntryField("Phone number",
                                validator: phoneValidator),
                            entryField("Password",
                                validator: passwordValidator, isPassword: true)
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    submitButton(context, validateForm, "Register"),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: backButton(context)),
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
