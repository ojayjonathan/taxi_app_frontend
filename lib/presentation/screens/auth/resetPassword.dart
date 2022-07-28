import 'package:flutter/material.dart';
import 'package:taxi_app/data/auth_services.dart';
import 'package:taxi_app/data/exception.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/presentation/widgets/entry_field.dart';
import 'package:taxi_app/presentation/widgets/paints/bezierContainer.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:taxi_app/resources/utils/validators.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _newPasswordKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _resetCodeController = TextEditingController();
  final TextEditingController _newPassordController = TextEditingController();
  bool hidePassword = true;
  late String uid;
  void resetPassword() async {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (formKey.currentState?.validate() == true) {
      try {
        final res = await UserAuthentication.resetPassword(
            data: {"email": _emailController.text.trim()});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(res["message"],
                style: TextStyle(color: Palette.successColor))));
        setState(() {
          uid = res["uid"];
        });
        showDialog<void>(context: context, builder: (context) => _dialog());
      } on Failure catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.message,
          style: TextStyle(color: Theme.of(context).errorColor),
        )));
      }
    }
  }

  void setNewPassword() async {
    if (_newPasswordKey.currentState?.validate() == true) {
      ScaffoldMessenger.of(context).clearSnackBars();

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
      } on Failure catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            duration: Duration(milliseconds: 10000),
          ),
        );
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
      text: TextSpan(
        children: [
          TextSpan(
            text: 'mat',
            style: TextStyle(color: Palette.headerColor, fontSize: 30),
          ),
          TextSpan(
            text: 'ndogo',
            style: TextStyle(color: Palette.accentColor, fontSize: 30),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  _title(),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: entryField("Email",
                        hintText: "johndoe@gmail.com",
                        icon: Icons.email,
                        validator: emailValidator,
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
            Positioned(
                top: 0,
                right: 0,
                child: Hero(tag: "page_paint", child: BezierContainer())),
          ],
        ),
      ),
    );
  }

  Widget _dialog() {
    return AlertDialog(
      title: Text('Set new password'),
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
                    validator: requiredValidator,
                  ),
                  TextFormField(
                    controller: _newPassordController,
                    decoration: InputDecoration(
                        hintText: "New password",
                        suffix: InkWell(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: Icon(
                                hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Palette.dark[2]))),
                    validator: passwordValidator,
                    obscureText: hidePassword,
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
