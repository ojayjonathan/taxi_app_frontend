import 'package:flutter/material.dart';
import 'package:taxi_app/palette.dart';

class UserFeedBack extends StatefulWidget {
  const UserFeedBack({Key key}) : super(key: key);

  @override
  _UserFeedBackState createState() => _UserFeedBackState();
}

List<String> _dropDownItem = ['Z', 'A', 'B', 'C', 'D'];
String _selectedDropDownItem = _dropDownItem[0];

class _UserFeedBackState extends State<UserFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          child: Text("My Bookings"),
          color: Palette.dark[2],
        ),
        backgroundColor: Color(0xfffafafa),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: Text("Done",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              style: ElevatedButton.styleFrom(primary: Palette.accentColor),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(),
      ),
    );
  }
}
