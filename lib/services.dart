import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/exception.dart';
import 'package:taxi_app/screens/auth/auth_services.dart';
import 'constants.dart';

class BookingServices {
  static Dio dio =
      Dio(BaseOptions(connectTimeout: timeout, receiveTimeout: timeout));
  static Future<List<dynamic>> getroutes() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString("travelRoutes") == null) {
      try {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        final response = await dio.get("${ipAddress}api/routes/",
            options: Options(sendTimeout: timeout));
        _prefs.setString("travelRoutes", jsonEncode(response.data));
        return response.data as List;
      } on Failure catch (e) {
        throw getException(e);
      }
    }
    return jsonDecode(_prefs.getString("travelRoutes")) as List<dynamic>;
  }

  static Future<List<dynamic>> getTrips({String q: ""}) async {
    try {
      final response = await dio.get("${ipAddress}api/trip/",
          queryParameters: {"q": q}, options: Options(sendTimeout: timeout));
      return response.data as List;
    } catch (e) {
      throw getException(e);
    }
  }

  static Future cancelBooking({int bookId}) async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await dio.put("${ipAddress}api/customer/booking/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout),
          data: {"book_id": bookId});
      return response.data["message"];
    } catch (e) {
      throw getException(e);
    }
  }

  static Future makebooking(tripId, numSeats) async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await dio.post("${ipAddress}api/customer/booking/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout),
          data: {"trip_id": tripId, "seats_number": numSeats});
      return response.data;
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<void> confirmTrip(int tripId) async {
    //driver will confirm after he as arrived destination
  }
  static Future<List<dynamic>> getBookingHistory() async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await dio.get("${ipAddress}api/customer/booking/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout));
      return response.data as List<dynamic>;
    } catch (e) {
      throw getException(e);
    }
  }

  //trip_id
  static Future<List<dynamic>> getDriverTrips() async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await dio.get("${ipAddress}api/driver/trip/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout));
      return response.data as List;
    } catch (e) {
      throw getException(e);
    }
  }

  static Future<List<dynamic>> getDriverTripsCustomers(int tripId) async {
    try {
      String authToken = await UserAuthentication.getAuthToken();
      final response = await dio.post("${ipAddress}api/driver/trip/",
          options: Options(
              headers: {'Authorization': 'Token $authToken'},
              sendTimeout: timeout),
          data: {"trip_id": tripId});
      return response.data as List;
    } catch (e) {
      throw getException(e);
    }
  }
}

Future<Map> feedback(String message) async {
  try {
    String authToken = await UserAuthentication.getAuthToken();
    final response = await Dio().post("${ipAddress}api/feedback/",
        options: Options(
            headers: {'Authorization': 'Token $authToken'},
            sendTimeout: timeout),
        data: {"message": message});
    return response.data as Map;
  } catch (e) {
    throw getException(e);
  }
}
