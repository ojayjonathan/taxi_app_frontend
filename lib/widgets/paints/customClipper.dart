import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    var height = size.height;
    var width = size.width;
    var path = new Path();
    path.moveTo(width, 0);
    path.lineTo(width, height * 0.5);
    path.quadraticBezierTo(width * .85, height * .6, width * 0.75, height * .4);
    path.quadraticBezierTo(width * .7, height * .25, width * .5, height * .33);
    path.quadraticBezierTo(width * 0.3, height * .25, width * .4, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
