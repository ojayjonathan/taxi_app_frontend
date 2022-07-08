import 'package:flutter/material.dart';
import 'package:taxi_app/presentation/widgets/paints/curvePaint.dart';
import 'package:taxi_app/resources/palette.dart';

class Trip extends StatelessWidget {
  const Trip({Key key}) : super(key: key);
  //TODO:fetch data
  void _confirmTrip() {
    //TODO:confirm tip api
  }
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Stack(
              children: [
                Hero(tag: "page_paint", child: CurvePaint()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: _height * 0.15),
                    child: Text("Trips",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Palette.headerColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28)),
                  ),
                ),
              ],
            ),
            _tripCard(),
            _tripCard(),
          ],
        ),
      ),
    );
  }

  Widget _tripCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: Palette.backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kitale - Kisii",
                style: TextStyle(
                    color: Palette.dark[2],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "Pending",
                style: TextStyle(
                    color: Palette.dark[3], fontWeight: FontWeight.w500),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: _confirmTrip,
                child: Text("confirm"),
              ),
              TextButton(
                onPressed: () {},
                child: Text("view"),
              )
            ],
          )
        ],
      ),
    );
  }
}
