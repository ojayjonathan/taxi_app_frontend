import 'package:flutter/material.dart';
import 'package:taxi_app/palette.dart';

class UserFeedBack extends StatefulWidget {
  const UserFeedBack({Key key}) : super(key: key);

  @override
  _UserFeedBackState createState() => _UserFeedBackState();
}


class _UserFeedBackState extends State<UserFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          child: Text("Feedback"),
          color: Palette.dark[2],
        ),
        backgroundColor: Color(0xfffafafa),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: Text("submit",
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
        child: ListView(
          children: [
            Form(
              child: TextFormField(
                maxLines: 8,
                minLines: 6,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                    hintText: "write your feedback"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
