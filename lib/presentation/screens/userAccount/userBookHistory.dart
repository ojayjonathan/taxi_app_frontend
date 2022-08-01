import 'package:flutter/material.dart';
import 'package:taxi_app/data/exception.dart';
import 'package:taxi_app/data/models.dart';
import 'package:taxi_app/data/services.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';

class BookHistory extends StatefulWidget {
  @override
  _BookHistoryState createState() => _BookHistoryState();
}

class _BookHistoryState extends State<BookHistory> {
  List<dynamic>? _bookings;
  Map<String, Color>? scaffoldData;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _showSnackBar(
    String message,
    Color color, {
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(color: color),
        ),
        action: action));
  }

  void fetchData() async {
    try {
      List apiData = await BookingServices.getBookingHistory();
      setState(() {
        _bookings = apiData;
      });
    } on Failure catch (e) {
      _showSnackBar(e.message, Theme.of(context).errorColor,
          action: SnackBarAction(
              label: "retry",
              onPressed: () async {
                fetchData();
              }));
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
          color: Colors.white,
          child: const Text(
            "My Bookings",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        // backgroundColor: Color(0xfffafafa),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        child: _bookings == null
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black87),
              )
            : ListView(
                children: [
                  ..._bookings!
                      .map((item) => _bookingCard(TripBooking.fromJson(item))),
                  _bookings!.isEmpty
                      ? const Text("You haven't booked any trip yet")
                      : const SizedBox(
                          height: 0,
                        )
                ],
              ),
      ),
    );
  }

  Widget _tripDetails(TripBooking book) {
    return AlertDialog(
      title: const Text('Trip Details'),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vehicle Capacity: ${book.trip.vehicle.capacity} seats"),
            const SizedBox(height: 5),
            Text("Vehicle Color: ${book.trip.vehicle.color}"),
            const SizedBox(height: 5),
            Text("Vehicle Reg No: ${book.trip.vehicle.regNumber}"),
            const SizedBox(height: 5),
            Text("Driver Contact: ${book.trip.driver.phoneNumber}"),
            book.trip.departure != null
                ? Text("Departure: ${book.trip.departure}")
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

  Widget _bookingCard(TripBooking book) {
    String statusKey = book.status;
    final Map statusMap = {"A": "Active", "C": "Canceled", "F": "Fullfiled"};
    Map<String, Color> colors = {
      "F": Colors.amber,
      "A": Palette.successColor,
      "C": Theme.of(context).errorColor
    };
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
                  "${book.trip.route.origin} - ${book.trip.route.destination}",
                  style: textStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Status: ",
                    style: textStyle,
                  ),
                  TextSpan(
                    text: "${statusMap[statusKey]}",
                    style: TextStyle(
                        color: colors[statusKey], fontWeight: FontWeight.w500),
                  )
                ]))
              ],
            ),
            TextButton(
                onPressed: () => showDialog<void>(
                    context: context, builder: (context) => _tripDetails(book)),
                child: const Text("Details")),
            statusKey == "A"
                ? TextButton(
                    onPressed: () => _cancelBooking(book.id),
                    child: const Text("Cancel"))
                : TextButton(
                    child: const Text("Feedback"),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.feedback))
          ],
        ),
      ),
    );
  }
}
