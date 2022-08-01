part of 'client.dart';

// ignore: constant_identifier_names
const BASE_URL = "";

class ApiEndpoints {
  //Auth routes
  static const login = "/api/auth/login/";
  static const resetPassword = "/api/auth/reset/";

  //Customer routes
  static const customerTrip = "/api/trip/";
  static const routes = "/api/routes/";
  static const customerBooking = "/api/customer/booking/";
  static const customerRegister = "/api/customer/register/";
  static const customerProfile = "/api/customer/profile/";

  //Driver routes
  static const driverBooking = "/api/driver/booking/";
  static const driverTrip = "/api/driver/booking/";

  //Other
  static const feedBack = "/api/feedback";
}
