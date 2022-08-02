import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/graphics/noConnectio.svg", width: 200),
            Text("Please check your internet connection")
          ],
        ),
      ),
    );
  }
}
