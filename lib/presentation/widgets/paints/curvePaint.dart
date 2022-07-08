import 'package:flutter/material.dart';

class CurvePainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(width * 0.5, height * 0.1, width, height * 0.25);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurvePaint extends StatelessWidget {
  const CurvePaint({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ClipPath(
      clipper: CurvePainter(),
      child: Container(
        height: MediaQuery.of(context).size.height * .25,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffe46b10), Color(0xfffbb448)])),
      ),
    ));
  }
}
