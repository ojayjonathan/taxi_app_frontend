import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/serializers.dart';
import 'package:taxi_app/services.dart';

class BookHistory extends StatefulWidget {
  @override
  _BookHistoryState createState() => _BookHistoryState();
}

class _BookHistoryState extends State<BookHistory> {
  List<dynamic> _bookings;
  bool loading = true;
  Map<String, Color> scaffoldData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void _showSnackBar(String message, Color color,
      {SnackBarAction action, Duration duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(color: color),
        ),
        duration: duration,
        action: action));
  }

  void fetchData() async {
    try {
      _bookings = await BookingServices.getBookingHistory();
    } on SocketException catch (e) {
      _showSnackBar(e.message.toString(), Theme.of(context).errorColor,
          action: SnackBarAction(
            label: "retry",
            onPressed: () async {
              _bookings = await BookingServices.getBookingHistory();
            },
          ),
          duration: Duration(seconds: 10));
    } on DioError catch (e) {
      _showSnackBar(e.response.toString(), Theme.of(context).errorColor);
    }
    loading = false;
  }

  void _cancelBooking(int bookId) async {
    try {
      _showSnackBar("Submiting please wait...", Palette.successColor);
      _bookings = await BookingServices.cancelBooking(bookId: bookId);
    } on SocketException catch (e) {
      _showSnackBar(e.message.toString(), Theme.of(context).errorColor);
    } on DioError catch (e) {
      _showSnackBar(e.response.toString(), Theme.of(context).errorColor);
    }
  }

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
        child: loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black87),
              )
            : ListView(
                children: <Widget>[
                  ..._bookings.map((item) =>
                      _bookingCard(CustomerTripBooking.fromJson(item))),
                  _bookings.length == 0 ??
                      Text("You haven't booked any trip yet")
                ],
              ),
      ),
    );
  }

  Widget _bookingCard(CustomerTripBooking _book) {
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
                "${_book.trip.route.origin} - ${_book.trip.route.destination}",
                style: TextStyle(
                    color: Palette.dark[2],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Status: ${_book.status}",
                style: TextStyle(
                    color: Palette.dark[3], fontWeight: FontWeight.w500),
              )
            ],
          ),
          TextButton(
              onPressed: () => _cancelBooking(_book.id), child: Text("Cancel")),
        ],
      ),
    );
  }
}
