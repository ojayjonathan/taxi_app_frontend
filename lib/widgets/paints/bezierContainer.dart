import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset("assets/graphics/rp.svg"),
    );
  }
}
