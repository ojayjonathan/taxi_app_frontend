import 'package:flutter/material.dart';
import 'package:taxi_app/data/auth_services.dart';
import 'package:taxi_app/data/rest/client.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/presentation/widgets/entry_field.dart';
import 'package:taxi_app/presentation/widgets/paints/bezierContainer.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:taxi_app/resources/utils/validators.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
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
      final res = await Client.customer
          .passwordReset({"email": _emailController.text.trim()});
      res.when((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.message,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          ),
        );
      }, (data) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data["message"],
                style: TextStyle(color: Palette.successColor))));
        setState(() {
          uid = data["uid"];
        });
        showDialog<void>(context: context, builder: (context) => _dialog());
      });
    }
  }

  void setNewPassword() async {
    if (_newPasswordKey.currentState?.validate() == true) {
      ScaffoldMessenger.of(context).clearSnackBars();
      final res = await Client.customer.setNewPassword({
        "new_password": _newPassordController.text,
        "uid": uid,
        "short_code": _resetCodeController.text
      });
      res.when((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.message,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            duration: const Duration(milliseconds: 10000),
          ),
        );
      }, (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Password  changed successfuly",
              style: TextStyle(color: Palette.successColor),
            ),
          ),
        );
        Navigator.of(context).pushNamed(AppRoutes.login);
      });
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  _title(),
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  submitButton(context, resetPassword, "Reset Password"),
                ],
              ),
            ),
            Positioned(top: 40, left: 0, child: backButton(context)),
            const Positioned(
                top: 0,
                right: 0,
                child: Hero(
                    tag: "page_paint", child: BezierContainer())),
          ],
        ),
      ),
    );
  }

  Widget _dialog() {
    return AlertDialog(
      title: const Text('Set new password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
              key: _newPasswordKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _resetCodeController,
                    decoration: const InputDecoration(hintText: "Enter code"),
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
