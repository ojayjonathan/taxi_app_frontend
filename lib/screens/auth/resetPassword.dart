import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/screens/auth/auth_services.dart';
import 'package:taxi_app/screens/auth/loginPage.dart';
import 'package:taxi_app/widgets/buttons.dart';
import "package:taxi_app/widgets/entry_field.dart";
import 'package:taxi_app/widgets/paints/bezierContainer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:taxi_app/palette.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _newPasswordKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _resetCodeController = TextEditingController();
  TextEditingController _newPassordController = TextEditingController();
  String uid;
  void resetPassword() async {
    if (formKey.currentState.validate()) {
      try {
        final res = await UserAuthentication.resetPassword(
            data: {"email": _emailController.text});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(res["message"],
                style: TextStyle(color: Palette.successColor))));
        setState(() {
          uid = res["uid"];
        });
        showDialog<void>(context: context, builder: (context) => _dialog());
      } on DioError catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.response.toString(),
          style: TextStyle(color: Theme.of(context).errorColor),
        )));
      }
    }
  }

  void setNewPassword() async {
    if (_newPasswordKey.currentState.validate()) {
      try {
        final res = await UserAuthentication.setNewPassword(data: {
          "new_password": _newPassordController.text,
          "uid": uid,
          "short_code": _resetCodeController.text
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(res["message"],
                style: TextStyle(color: Palette.successColor))));
        Navigator.of(context).pushNamed(AppRoutes.login);
      } on DioError catch (e) {
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
    _emailController.dispose();
    _newPassordController.dispose();
    _resetCodeController.dispose();
    super.dispose();
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
              top: 0,
              right: 0,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .25),
                  _title(),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: entryField("Email",
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          EmailValidator(
                              errorText: "Please provide a valid email")
                        ]),
                        controller: _emailController),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  submitButton(context, resetPassword, "Reset Password"),
                ],
              ),
            ),
            Positioned(top: 40, left: 0, child: backButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _dialog() {
    return AlertDialog(
      title: Text('Confirm bookig'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
              key: _newPasswordKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _resetCodeController,
                    decoration: InputDecoration(hintText: "Enter code"),
                    keyboardType: TextInputType.number,
                    validator: RequiredValidator(errorText: "Required"),
                  ),
                  TextFormField(
                    controller: _newPassordController,
                    decoration: InputDecoration(hintText: "New password"),
                    validator: passwordValidator,
                  ),
                ],
              ))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('CANCEL', style: TextStyle(color: Palette.accentColor)),
        ),
        TextButton(
          onPressed: setNewPassword,
          child: Text('CONFIRM', style: TextStyle(color: Palette.accentColor)),
        ),
      ],
    );
  }
}
