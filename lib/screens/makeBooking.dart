import 'package:flutter/material.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/serializers.dart';
import 'package:taxi_app/services.dart';
import 'package:taxi_app/widgets/buttons.dart';

class BookConfirm extends StatefulWidget {
  const BookConfirm({Key key}) : super(key: key);
  @override
  _BookConfirmState createState() => _BookConfirmState();
}

class _BookConfirmState extends State<BookConfirm> {
  List<dynamic> _availableTrip;
  int selectedSeats = 1;

  _BookConfirmState();
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _showSnackBar(String message, Color color,
      {SnackBarAction action, Duration duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(color: color),
        ),
        duration: duration ?? Duration(microseconds: 1000),
        action: action));
  }

  void _init() async {
    try {
      _availableTrip = await BookingServices.getTrips();
    } catch (e) {
      _showSnackBar("An error occured ...", Theme.of(context).errorColor,
          action: SnackBarAction(
              label: "retry",
              onPressed: () async {
                _init();
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Column(
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
            _availableTrip == null
                ? Container(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                )
                : ListView(
                    children: [
                      ..._availableTrip.map(
                          (trip) => _tripCard(TripSerializer.fromJson(trip))),
                      _availableTrip.length == 0 ??
                          Text("No schedule found for this  route")
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Widget _tripCard(TripSerializer trip) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Route: ${trip.route.origin} - ${trip.route.destination}",
                style: textstyle),
            Text("Departure: ${trip.departure}", style: textstyle),
            Text("Available seats: ${trip.availableSeats}", style: textstyle)
          ],
        ),
        //TODO:open dialog box for booking
        TextButton(onPressed: () {}, child: Text("book")),
      ],
    );
  }

TextStyle textstyle = TextStyle(
    color: Palette.dark[2], fontWeight: FontWeight.bold, fontSize: 18);
}
