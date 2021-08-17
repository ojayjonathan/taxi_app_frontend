import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/exception.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/serializers.dart';
import 'package:taxi_app/services.dart';

class BookHistory extends StatefulWidget {
  @override
  _BookHistoryState createState() => _BookHistoryState();
}

class _BookHistoryState extends State<BookHistory> {
  List<dynamic> _bookings;
  Map<String, Color> scaffoldData;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _showSnackBar(String message, Color color, {SnackBarAction action}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(color: color),
        ),
        action: action));
  }

  void fetchData() async {
    try {
      List _apiData = await BookingServices.getBookingHistory();
      setState(() {
        _bookings = _apiData;
      });
    } on Failure catch (e) {
      _showSnackBar(e.message, Theme.of(context).errorColor,
          action: SnackBarAction(
              label: "retry",
              onPressed: () async {
                fetchData();
              }));
    } on DioError catch (e) {
      _showSnackBar(e.response.toString(), Theme.of(context).errorColor);
    }
  }

  void _cancelBooking(int bookId) async {
    try {
      _showSnackBar("Submiting please wait...", Palette.successColor);
      await BookingServices.cancelBooking(bookId: bookId);
      _showSnackBar(
        "Book has been canceled",
        Palette.successColor,
      );
    } on Failure catch (e) {
      _showSnackBar(e.message, Theme.of(context).errorColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Title(
          child: Text(
            "My Bookings",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          color: Colors.white,
        ),
        // backgroundColor: Color(0xfffafafa),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: _bookings == null
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black87),
              )
            : ListView(
                children: <Widget>[
                  ..._bookings.map((item) =>
                      _bookingCard(CustomerTripBooking.fromJson(item))),
                  _bookings.isEmpty
                      ? Text("You haven't booked any trip yet")
                      : SizedBox(
                          height: 0,
                        )
                ],
              ),
      ),
    );
  }

  Widget _tripDetails(CustomerTripBooking _book) {
    return AlertDialog(
      title: Text('Trip Details'),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vehicle Capacity: ${_book.trip.vehicle.capacity} seats"),
            SizedBox(height: 5),
            Text("Vehicle Color: ${_book.trip.vehicle.color}"),
            SizedBox(height: 5),
            Text("Vehicle Reg No: ${_book.trip.vehicle.regNumber}"),
            SizedBox(height: 5),
            Text("Driver Contact: ${_book.trip.driver.phoneNumber}"),
            _book.trip.departure != null
                ? Text("Departure: ${_book.trip.departure}")
                : Container()
          ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('CLOSE', style: TextStyle(color: Palette.accentColor)),
        ),
      ],
    );
  }

  TextStyle textStyle = TextStyle(
      color: Palette.dark[2], fontWeight: FontWeight.w500, fontSize: 16);

  Widget _bookingCard(CustomerTripBooking _book) {
    String _statusKey = _book.status;
    final Map _statusMap = {"A": "Active", "C": "Canceled", "F": "Fullfiled"};
    Map<String, Color> colors = {
      "F": Colors.amber,
      "A": Palette.successColor,
      "C": Theme.of(context).errorColor
    };
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shadowColor: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_book.trip.route.origin} - ${_book.trip.route.destination}",
                  style: textStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Status: ",
                    style: textStyle,
                  ),
                  TextSpan(
                    text: "${_statusMap[_statusKey]}",
                    style: TextStyle(
                        color: colors[_statusKey], fontWeight: FontWeight.w500),
                  )
                ]))
              ],
            ),
            TextButton(
                onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => _tripDetails(_book)),
                child: Text("Details")),
            _statusKey == "A"
                ? TextButton(
                    onPressed: () => _cancelBooking(_book.id),
                    child: Text("Cancel"))
                : TextButton(
                    child: Text("Feedback"),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.feedback))
          ],
        ),
      ),
    );
  }
}
