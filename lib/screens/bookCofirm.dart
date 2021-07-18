import 'package:flutter/material.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/widgets/buttons.dart';

class BookConfirm extends StatefulWidget {
  const BookConfirm({Key key}) : super(key: key);

  @override
  _BookConfirmState createState() => _BookConfirmState();
}

class _BookConfirmState extends State<BookConfirm> {
  @override
  void initState() {
    Map selectedRoute;
    int selectedSeats = 1;
    super.initState();
  }

  double _sliderDiscreteValue = 1;

  DateTime _date = DateTime(2020, 11, 17);

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            backButton(context),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                "Booking",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Palette.headerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      SizedBox(
                        width: 80,
                        child: Text("From:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Palette.dark[2])),
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
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Select Number Of Seats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Palette.dark[2]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Slider(
                        value: _sliderDiscreteValue,
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: _sliderDiscreteValue.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _sliderDiscreteValue = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      "${_sliderDiscreteValue.toInt()}",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Select Departure Date",
                      style: TextStyle(
                        color: Palette.dark[2],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_date.toLocal().toString(),
                            style: TextStyle(
                                color: Palette.dark[2], fontSize: 14)),
                        IconButton(
                            onPressed: _selectDate,
                            icon: Icon(
                              Icons.calendar_today,
                              color: Palette.accentColor,
                              size: 40,
                            ))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Ksh: ${"\t" * 7}',
                            style:
                                TextStyle(color: Palette.dark[2], fontSize: 20),
                          ),
                          TextSpan(
                            text: '3000',
                            style: TextStyle(
                                color: Palette.successColor, fontSize: 20),
                          ),
                        ]),
                      ),
                    ),
                    actionButton(context, "Book", () {})
                  ]),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Palette.backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
