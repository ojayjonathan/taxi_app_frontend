import 'package:flutter/material.dart';
import 'package:taxi_app/resources/palette.dart';

class _WelcomePagePainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();
    path.lineTo(0, size.height * 0.9);
    path.quadraticBezierTo(width * 0.25, height * 1.1, width, height * 0.5);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WelcomePagePaint extends StatelessWidget {
  const WelcomePagePaint({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: _WelcomePagePainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .25,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Palette.primaryColor,
                Palette.primary2Color,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
