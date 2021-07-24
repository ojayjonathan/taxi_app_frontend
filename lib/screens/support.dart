import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/palette.dart';

// ignore: must_be_immutable
class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/graphics/contact.svg", width: 300),
                Card(
                  elevation: 2,
                  shadowColor: Colors.grey[250],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.phone,
                          size: 20,
                          color: Palette.accentColor,
                        ),
                      ),
                      Text("+254742446941", style: textStyle)
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 2,
                  shadowColor: Colors.grey[250],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.email,
                            size: 32,
                            color: Palette.accentColor,
                          ),
                        ),
                        Text("testaccount@gmail.com", style: textStyle)
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          index: 2,
          height: 50,
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

  TextStyle textStyle = TextStyle(
      color: Palette.dark[2], fontWeight: FontWeight.bold, fontSize: 18);
}
