import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/screens/auth/loginPage.dart';
import 'package:taxi_app/widgets/buttons.dart';
import 'package:taxi_app/widgets/paints/curvePaint.dart';

List<Map> trips = [
  {"from": "Nakuru", "to": "Nairobi", "cost": "3000"},
  {"from": "Kisii", "to": "Nairobi", "cost": "5000"},
  {"from": "Nakuru", "to": "Nairobi", "cost": "3000"},
  {"from": "Kisii", "to": "Nairobi", "cost": "5000"},
  {"from": "Nakuru", "to": "Nairobi", "cost": "3000"},
  {"from": "Kisii", "to": "Nairobi", "cost": "5000"},
  {"from": "Nakuru", "to": "Nairobi", "cost": "3000"},
  {"from": "Kisii", "to": "Nairobi", "cost": "5000"},
  {"from": "Nakuru", "to": "Nairobi", "cost": "3000"},
  {"from": "Kisii", "to": "Nairobi", "cost": "5000"},
];

class Booking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Widget _card(Map item) {
      return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${item["from"]} - ${item["to"]}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.dark[2],
                  fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Ksh ${item["cost"]}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.dark[2],
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            actionButton(context, "Book Now", () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 1000),
                      pageBuilder: (context, _, __) => LoginPage()));
            })
          ],
        ),
        decoration: BoxDecoration(
          color: Palette.backgroundColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
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
            print(index);
          }),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: Hero(tag: "page_paint", child: CurvePaint()),
                  top: 0,
                  left: 0,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: height * 0.1),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              elevation: 10,
                              shadowColor: Colors.grey[300],
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xffffff),
                                    hintText: "Search",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 0, 10, 0)),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: Palette.accentColor,
                                size: 40,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.08),
                  ],
                )
              ],
            ),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  // ignore: sdk_version_ui_as_code
                  ...trips.map((item) => _card(item))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}