import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/data/rest/client.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/presentation/widgets/entry_field.dart';
import 'package:taxi_app/presentation/widgets/paints/bezierContainer.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:taxi_app/resources/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  //will be used for push notification
  String? _registartionToken;

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
    if (formkey.currentState!.validate() && !_submiting) {
      ScaffoldMessenger.of(context).clearSnackBars();
      _submiting = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Submiting please wait...',
            style: TextStyle(color: Palette.successColor),
          ),
          duration: const Duration(milliseconds: 10000),
        ),
      );
      final res = await Client.customer.login({
        "email": _email.text.trim(),
        "password": _password.text,
        "registration_id": _registartionToken
      });
      res.when((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.message,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            duration: const Duration(seconds: 30),
          ),
        );
      }, (data) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login was sucessfull",
              style: TextStyle(color: Palette.successColor),
            ),
          ),
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      });
    }
  }

  Widget _createAccountLabel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(width: 10),
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
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Center(
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _title(),
                      const SizedBox(height: 10),
                      Form(
                        key: formkey,
                        child: Column(children: <Widget>[
                          entryField(
                            "Email",
                            controller: _email,
                            icon: Icons.email,
                            hintText: "john@gmail.com",
                            validator: emailValidator,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          PasswordField(_password)
                        ]),
                      ),
                      const SizedBox(height: 10),
                      submitButton(context, validateForm, "Login"),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.resetPassword),
                          child: const Text('Forgot Password ?',
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
      ),
    );
  }
}
