import 'package:dio/dio.dart';
import 'package:taxi_app/data/models/exception.dart';
import 'package:taxi_app/data/models/models.dart';
import 'package:taxi_app/data/providers/auth.dart';

part 'http_client.dart';
part 'endpoints.dart';

class _Customer {
  Result<String> login(Map data) => Http.post(
        ApiEndpoints.login,
        data,
        deserializer: (data) => data["token"],
      );
  Result<String> register(Map data) => Http.post(
        ApiEndpoints.customerRegister,
        data,
      );
  Result<User> customerProfile() => Http.get(
        ApiEndpoints.customerProfile,
        deserializer: (json) => User.fromJson(json),
      );
  Result<User> profileUpdate(Map data) => Http.post(
        ApiEndpoints.customerProfile,
        data,
        deserializer: (json) => User.fromJson(json),
      );
  Result<Map> passwordReset(Map data) => Http.post(
        ApiEndpoints.resetPassword,
        data,
      );
  Result<Map> setNewPassword(Map data) => Http.put(
        ApiEndpoints.resetPassword,
        data,
      );
  Result<Iterable<TravelRoute>> routes() => Http.get(
        ApiEndpoints.routes,
        deserializer: (data) => data.map(
          (json) => TravelRoute.fromJson(json),
        ),
      );
  Result<Iterable<TripModel>> trips(Map<String, dynamic> q) => Http.get(
        ApiEndpoints.customerTrip,
        queryParams: q,
        deserializer: (data) => data.map(
          (json) => TripModel.fromJson(json),
        ),
      );
  Result<TripBooking> book(int tripId, int numSeats) => Http.post(
        ApiEndpoints.customerBooking,
        {"trip_id": tripId, "seats_number": numSeats},
        deserializer: (json) => TripBooking.fromJson(json),
      );
  Result<String> cancelBooking(int bookId) => Http.put(
        ApiEndpoints.customerBooking,
        {"book_id": bookId},
        deserializer: (data) => data["message"],
      );
  Result<Iterable<TripBooking>> allBookings() => Http.get(
        ApiEndpoints.customerBooking,
        deserializer: (data) => data.map(TripBooking.fromJson),
      );
  Result feedback(String message) => Http.post(
        ApiEndpoints.feedBack,
        {"message": message},
        deserializer: (json) => TripBooking.fromJson(json),
      );
}

class _Driver {}

class Client {
  static final driver = _Driver();
  static final customer = _Customer();
}
