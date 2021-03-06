import 'package:flutter/material.dart';
import 'package:taxi_app/data/exception.dart';
import 'package:taxi_app/data/models.dart';
import 'package:taxi_app/data/services.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';

class BookConfirm extends StatefulWidget {
  final Map<String, dynamic> selectedRoute;
  const BookConfirm({Key? key, required this.selectedRoute}) : super(key: key);
  @override
  _BookConfirmState createState() => _BookConfirmState();
}

class _BookConfirmState extends State<BookConfirm> {
  List<dynamic>? _availableTrip;
  final TextEditingController _numSeatsController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TripSerializer? _selectedTrip;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _showSnackBar(
    String message,
    Color color, {
    SnackBarAction? action,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(color: color),
        ),
        duration: duration ?? const Duration(milliseconds: 10000),
        action: action));
  }

  void _init() async {
    try {
      List _apiData = await BookingServices.getTrips(q: widget.selectedRoute);
      setState(() {
        _availableTrip = _apiData;
      });
    } on Failure catch (e) {
      _showSnackBar(e.message, Theme.of(context).errorColor,
          action: SnackBarAction(label: "retry", onPressed: _init));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Booking",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 28),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        child: _availableTrip != null
            ? Column(
                children: <Widget>[
                  ..._availableTrip!
                      .map((trip) => _tripCard(TripSerializer.fromJson(trip))),
                  _availableTrip!.isEmpty
                      ? const Text("No trip scheduled for this route")
                      : const SizedBox(
                          height: 0,
                        )
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black87),
                ),
              ),
      ),
    );
  }

  Widget _tripCard(TripSerializer trip) {
    String departure = trip.departure;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shadowColor: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Route: ${trip.route.origin} - ${trip.route.destination}",
                    style: textstyle),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: departure != null
                        ? Text("Departure: ${trip.departure}", style: textstyle)
                        : const SizedBox(height: 0)),
                Text("Available seats: ${trip.availableSeats}",
                    style: textstyle)
              ],
            ),
            actionButton(context, "Book Now", () {
              setState(() {
                _numSeatsController.text = trip.availableSeats.toString();
                _selectedTrip = trip;
              });
              showDialog<void>(
                  context: context, builder: (context) => _dialog());
            }, padding: 5),
          ],
        ),
      ),
    );
  }

  Widget _dialog() {
    String? _validator(String? value) {
      if (value == null) {
        return "Required";
      }
      if (int.parse(value) > _selectedTrip!.availableSeats) {
        return "You can book a maximun of ${_selectedTrip!.availableSeats} seats";
      }
      if (int.parse(value) < 0) {
        return "Provide valid number";
      } else {
        return null;
      }
    }

    void _makeBooking() async {
      if (_form.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Submiting please wait...",
              style: TextStyle(color: Palette.successColor),
            ),
          ),
        );
        try {
          await BookingServices.makebooking(
              _selectedTrip!.id, int.parse(_numSeatsController.text));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Your booking has been confirmed",
                  style: TextStyle(color: Palette.successColor))));
          Navigator.of(context).popAndPushNamed(AppRoutes.bookHistory);
        } on Failure catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            ),
          );
        }
      }
    }

    return Container(
      height: 300,
      child: AlertDialog(
        title: const Text('Confirm booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Vehicle capacity: ${_selectedTrip!.vehicle.capacity} seats"),
            Form(
              key: _form,
              child: TextFormField(
                controller: _numSeatsController,
                decoration: const InputDecoration(
                    helperText: "Select number of seats to book"),
                validator: _validator,
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CANCEL',
              style: TextStyle(color: Palette.accentColor),
            ),
          ),
          TextButton(
            onPressed: _makeBooking,
            child:
                Text('CONFIRM', style: TextStyle(color: Palette.accentColor)),
          ),
        ],
      ),
    );
  }

  TextStyle textstyle =
      TextStyle(color: Palette.dark[3], fontWeight: FontWeight.w600);
}
