import "package:flutter/material.dart";
import 'package:taxi_app/resources/palette.dart';

Widget submitButton(
  BuildContext context,
  Function() validateForm,
  String label, {
  double fontSize = 20,
  double borderRadius = 5,
}) {
  return InkWell(
    onTap: validateForm,
    splashColor: Colors.red,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Palette.primary2Color,
            Palette.primaryColor,
          ],
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    ),
  );
}

Widget backButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: const Icon(
              Icons.keyboard_arrow_left,
              color: Color(0xff090817),
            ),
          ),
          const Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}

Widget actionButton(
  BuildContext context,
  String label,
  Function() onPressed, {
  double padding = 8,
}) {
  return TextButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(primary: Palette.accentColor),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: padding),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Palette.accentColor),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}

Widget outLineBtn() {
  return OutlinedButton.icon(
    icon: const Icon(Icons.star_outline),
    label: const Text("OutlinedButton"),
    onPressed: () => print("it's pressed"),
    style: ElevatedButton.styleFrom(
      side: const BorderSide(width: 2.0, color: Colors.blue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
  );
}

Widget cancelButton(
  BuildContext context,
  String label,
  Function() onPressed,
) {
  return TextButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      primary: const Color(0xffACAFC7),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Color(0xffACAFC7)),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}
