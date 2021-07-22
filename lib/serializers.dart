import 'dart:convert';

class User {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String profileImage;

  User(
      {this.userId,
      this.email,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.phoneNumber});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json["user"]['id'],
        email: json["user"]["email"],
        lastName: json["user"]["last_name"],
        firstName: json["user"]["first_name"],
        phoneNumber: json["user"]["phone_number"],
        profileImage: json["profile_image"]);
  }
}
