import 'dart:io';
import 'package:dio/dio.dart';
import 'package:taxi_app/screens/auth/auth_services.dart';
import 'constants.dart';

class BookingServices {
  static Future<List<dynamic>> getroutes() async {
    try {
      final response = await Dio().get("${ipAddress}api/routes/");
      return response.data as List;
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  static Future<List<dynamic>> getTrips({String query: ""}) async {
    try {
      final response = await Dio()
          .post("${ipAddress}api/trip/", queryParameters: {"from": query});
      return response.data as List;
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  static Future cancelBooking({int bookId}) async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await Dio().put("${ipAddress}api/customer/booking/",
          options: Options(headers: {'Authorization': 'Token $authToken'}),
          data: {"book_id": bookId});
      return response.data["message"];
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  static Future makebooking(tripId, numSeats) async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await Dio().post("${ipAddress}api/customer/booking/",
          options: Options(headers: {'Authorization': 'Token $authToken'}),
          data: {"trip_id": tripId, "seats_number": numSeats});
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  static Future<void> confirmTrip(int tripId) async {
    //driver will confirm after he as arrived destination
  }
  static Future<List<dynamic>> getBookingHistory() async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await Dio().get("${ipAddress}api/customer/booking/",
          options: Options(headers: {'Authorization': 'Token $authToken'}));
      return response.data as List<dynamic>;
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  //trip_id
  static Future<List<dynamic>> getDriverTrips() async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await Dio().get("${ipAddress}api/driver/trip/",
          options: Options(headers: {'Authorization': 'Token $authToken'}));
      return response.data as List;
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }

  static Future<List<dynamic>> getDriverTripsCustomers(int tripId) async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await Dio().post("${ipAddress}api/driver/trip/",
          options: Options(headers: {'Authorization': 'Token $authToken'}),
          data: {"trip_id": tripId});
      return response.data as List;
    } on SocketException catch (e) {
      throw SocketException(e.message.toString());
    } on DioError catch (e) {
      throw DioError(requestOptions: null, response: e.response ?? e.message);
    }
  }
}
