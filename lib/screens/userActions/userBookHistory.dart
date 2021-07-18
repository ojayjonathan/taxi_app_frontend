import 'package:flutter/material.dart';
import 'package:taxi_app/palette.dart';

class BookHistory extends StatelessWidget {
  const BookHistory({Key key}) : super(key: key);
  //TODO:fetch data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          child: Text(
            "My Bookings",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          color: Palette.headerColor,
        ),
        backgroundColor: Color(0xfffafafa),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            _booking(),
            _booking(),
          ],
        ),
      ),
    );
  }

  Widget _booking() {
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
              SizedBox(height: 5,),
              Text(
                "12/03/2020",
                style: TextStyle(
                    color: Palette.dark[3], fontWeight: FontWeight.w500),
              )
            ],
          ),
          TextButton(onPressed: () {}, child: Text("Cancel")),
        ],
      ),
    );
  }
}
