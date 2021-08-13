import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/exception.dart';
import 'package:taxi_app/palette.dart';
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
  //for filtering in search
  List<dynamic> operationRoutesAll;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    try {
      List _operationRoutes = await BookingServices.getroutes();
      setState(() {
        operationRoutes = _operationRoutes;
        operationRoutesAll = _operationRoutes;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } on Failure catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString(),
            style: TextStyle(color: Theme.of(context).errorColor)),
        duration: Duration(seconds: 10000),
        action: SnackBarAction(label: "retry", onPressed: fetchData),
      ));
    }
  }

  Future<void> refreshData() async {
    try {
      List response = await BookingServices.refreshroutes();
      operationRoutes = response;
      operationRoutesAll = response;
      setState(() {});
    } catch (_) {}
  }

  void filterData(String text) {
    text = text.toLowerCase();
    Iterable<dynamic> _routesFiltered = operationRoutesAll.where((item) {
      return (item["origin"]["name"].toLowerCase().contains(text) ||
          item["destination"]["name"].toLowerCase().contains(text));
    });
    setState(() {
      operationRoutes = _routesFiltered.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Widget _card(TravelRoute _route) {
      return Card(
        elevation: 3,
        shadowColor: Colors.grey[200],
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${_route.origin} - ${_route.destination}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Palette.dark[2],
                      fontSize: 14)),
              Text(
                "Ksh ${_route.cost}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Palette.dark[2],
                    fontSize: 15),
              ),
              actionButton(context, "Book Now", () {
                Navigator.pushNamed(context, AppRoutes.makeBooking, arguments: {
                  "from": _route.origin,
                  "to": _route.destination
                });
              }, padding: 5)
            ],
          ),
          decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );
    }

    Widget curvedNavigationBar = CurvedNavigationBar(
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
        });
    return Scaffold(
      bottomNavigationBar: curvedNavigationBar,
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: CurvePaint(),
                  top: 0,
                  left: 0,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: height * 0.1),
                    _searchField(),
                    SizedBox(height: height * 0.08),
                  ],
                )
              ],
            ),
            operationRoutes != null
                ? Expanded(
                    child: RefreshIndicator(
                      onRefresh: refreshData,
                      child: GridView.count(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        childAspectRatio: 1.2,
                        children: [
                          // ignore: sdk_version_ui_as_code
                          ...operationRoutes
                              .map((item) => _card(TravelRoute.fromJson(item))),
                          operationRoutes.isEmpty
                              ? Center(child:Text("Nothing was found"))
                              : SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                  )
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black87),
                  )
          ],
        ),
      ),
    );
  }

  Container _searchField() {
    return Container(
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
                onChanged: filterData,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xffffff),
                    hintText: "Search",
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              ),
            ),
          ),
          Material(
            elevation: 10,
            shadowColor: Colors.grey[300],
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Palette.accentColor,
                  size: 40,
                )),
          )
        ],
      ),
    );
  }
}
