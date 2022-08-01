import 'package:taxi_app/data/exception.dart';

class User {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? profileImage;

  User({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    required this.phoneNumber,
  });
  factory User.fromJson(json) {
    return User(
      userId: json["user"]['id'],
      email: json["user"]["email"],
      lastName: json["user"]["last_name"],
      firstName: json["user"]["first_name"],
      phoneNumber: (json["phone_number"] as String).replaceAll("+254", "0"),
      profileImage: json["profile_image"],
    );
  }
}

class TravelRoute {
  final String origin;
  final String destination;
  final int cost;
  final bool available;
  TravelRoute(
    this.origin,
    this.destination,
    this.cost,
    this.available,
  );
  factory TravelRoute.fromJson(Map<String, dynamic> json) {
    return TravelRoute(
      json["origin"]["name"],
      json["destination"]["name"],
      json["cost"],
      json["available"],
    );
  }
}

class TripModel {
  final TravelRoute route;
  final String arrival;
  final String departure;
  final String status;
  final int availableSeats;
  final int id;
  final User driver;
  final Vehicle vehicle;

  TripModel(
    this.arrival,
    this.departure,
    this.status,
    this.availableSeats,
    this.id,
    this.route,
    this.driver,
    this.vehicle,
  );
  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      json["arrival"],
      json["departure"],
      json["status"],
      json["available_seats"],
      json["id"],
      TravelRoute.fromJson(json["route"]),
      User.fromJson(json["driver"]),
      Vehicle.fromJson(json["vehicle"]),
    );
  }
}

class TripBooking {
  final int id;
  final TripModel trip;
  final int numSeats;
  final int cost;
  final String status;
  TripBooking(
    this.id,
    this.trip,
    this.numSeats,
    this.cost,
    this.status,
  );
  factory TripBooking.fromJson(json) {
    return TripBooking(
      json["id"],
      TripModel.fromJson(json["trip"]),
      json["seats"],
      json["cost"],
      json["status"],
    );
  }
}

class Vehicle {
  final String regNumber;
  final String color;
  final int capacity;

  Vehicle(this.regNumber, this.color, this.capacity);
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      json["vehicle_registration_number"],
      json["color"],
      json["seats"],
    );
  }
}

class HttpResult<T> {
  const factory HttpResult.onError({required Failure error}) = _ErrorResult;
  const factory HttpResult.onSuccess({required T data}) = _SuccessResult;
  when(Function(Failure error) onError, Function(T data) onSuccess) {}
}

class _ErrorResult<T> implements HttpResult<T> {
  final Failure error;
  const _ErrorResult({required this.error});

  @override
  when(Function(Failure) onError, Function(T) onSuccess) {
    onError(error);
  }
}

class _SuccessResult<T> implements HttpResult<T> {
  final T data;
  const _SuccessResult({required this.data});

  @override
  when(Function(Failure p1) onError, Function(T p1) onSuccess) {
    onSuccess(data);
  }
}
