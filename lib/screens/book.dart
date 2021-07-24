import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/screens/makeBooking.dart';
import 'package:taxi_app/serializers.dart';
import 'package:taxi_app/services.dart';
import 'package:taxi_app/widgets/buttons.dart';
import 'package:taxi_app/widgets/paints/curvePaint.dart';

class Booking extends StatefulWidget {
  const Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<dynamic> operationRoutes;
  bool _loading = true;
  void fetchData() async {
    try {
      operationRoutes = await BookingServices.getroutes();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
         "an error occured",
          style: TextStyle(color: Theme.of(context).errorColor),
        ),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: "retry",
          onPressed: () async {
            fetchData();
           _loading =true;
          },
        ),
      ));
    }
    _loading = false;
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Widget _card(TravelRoute _route) {
      return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${_route.origin} - ${_route.destination}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.dark[2],
                  fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Ksh ${_route.cost}",
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
                MaterialPageRoute(builder: (context) => BookConfirm()),
              );
            }, padding: 5)
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
          height: 50,
          index: 1,
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
            } else if (index == 2) {
              Navigator.of(context).pushNamed(AppRoutes.support);
            } else {
              Navigator.of(context).pushNamed(AppRoutes.home);
            }
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
            _loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black87),
                  )
                : Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      childAspectRatio: 1.2,
                      children: [
                        // ignore: sdk_version_ui_as_code
                        ...operationRoutes
                            .map((item) => _card(TravelRoute.fromJson(item)))
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
