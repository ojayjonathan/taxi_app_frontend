import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/palette.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: CurvedNavigationBar(
          index: 2,
          backgroundColor: Palette.accentColor,
          items: <Widget>[
            Icon(
              Icons.person,
              size: 30,
              color: Palette.dark[2],
            ),
            Icon(Icons.home, size: 30, color: Palette.dark[2]),
            Icon(Icons.phone, size: 30, color: Palette.dark[2]),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.of(context).pushNamed(AppRoutes.account);
            } else if (index == 1) {
              Navigator.of(context).pushNamed(AppRoutes.home);
            }
          }),
    );
  }
}
