import 'package:flutter/material.dart';
import 'package:taxi_app/resources/palette.dart';

class TripDetail extends StatelessWidget {
  const TripDetail({Key key}) : super(key: key);
  //TODO:fetch data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            _contact(),
            _contact(),
            Divider(),
            Column(
              children: <Widget>[
                Row(children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      "From:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Palette.dark[2],
                      ),
                    ),
                  ),
                  Text("Kisii",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.dark[2])),
                ]),
                SizedBox(
                  height: 5,
                ),
                Row(children: [
                  SizedBox(
                    width: 80,
                    child: Text("To:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Palette.dark[2])),
                  ),
                  Text("Nakuru",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.dark[2])),
                ]),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        "Date:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.dark[2],
                        ),
                      ),
                    ),
                    Text(
                      "12/01/2021",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Palette.dark[2],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Palette.dark[2],
                        ),
                      ),
                    ),
                    Text(
                      "Fulfiled",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Palette.dark[2],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _contact() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: ExactAssetImage('assets/profile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jonathan",
                    style: TextStyle(
                        color: Palette.dark[2],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    "+254742446941",
                    style: TextStyle(
                        color: Palette.dark[3], fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call),
          )
        ],
      ),
    );
  }
}
