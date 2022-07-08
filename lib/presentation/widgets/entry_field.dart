import 'package:flutter/material.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:taxi_app/resources/utils/validators.dart';

Widget entryField(String title,
    {Function validator,
    TextEditingController controller,
    IconData icon,
    String hintText,
    TextInputType keyboardType = TextInputType.name}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Palette.dark[2],
              fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              prefixIcon: Icon(icon),
              hintText: hintText),
          validator: validator,
          controller: controller,
          enableSuggestions: true,
          keyboardType: keyboardType,
        )
      ],
    ),
  );
}

Widget phoneEntryField(String title,
    {Function validator, TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Palette.dark[2],
              fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
            prefixIcon: Icon(Icons.phone),
            hintText: "0734434334",
          ),
          validator: validator,
          controller: controller,
          keyboardType: TextInputType.phone,
        )
      ],
    ),
  );
}

//password field
class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField(this.controller);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Password",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Palette.dark[2],
                fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: hidePassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              prefixIcon: Icon(Icons.lock),
              hintText: "password",
              suffix: InkWell(
                  onTap: () {
                    setState(
                      () {
                        hidePassword = !hidePassword;
                      },
                    );
                  },
                  child: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: Palette.dark[2],
                  )),
            ),
            validator: passwordValidator,
            controller: widget.controller,
          )
        ],
      ),
    );
  }
}
