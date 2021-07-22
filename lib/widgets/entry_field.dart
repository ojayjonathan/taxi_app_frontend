import 'package:flutter/material.dart';
import 'package:taxi_app/palette.dart';

Widget entryField(String title,
    {Function validator,
    bool isPassword = false,
    TextEditingController controller,
    IconData icon,
    String hintText,
   }) {
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
          
          obscureText: isPassword,
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              prefixIcon: Icon(icon),
              hintText: hintText),
          validator: validator,
          controller: controller,
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
            hintText: "734434334",
          ),
          validator: validator,
          controller: controller,
        )
      ],
    ),
  );
}
