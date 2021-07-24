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
        phoneNumber: json["phone_number"],
        profileImage: json["profile_image"]);
  }
}

class TravelRoute {
  final String origin;
  final String destination;
  final int cost;
  TravelRoute(this.origin, this.destination, this.cost);
  factory TravelRoute.fromJson(Map<String, dynamic> json) {
    return TravelRoute(
        json["origin"]["name"], json["destination"]["name"], json["cost"]);
  }
}

class TripSerializer {
  final TravelRoute route;
  final String arrival;
  final String departure;
  final String status;
  final int availableSeats;
  final int id;
  TripSerializer(this.arrival, this.departure, this.status, this.availableSeats,
      this.id, this.route);
  factory TripSerializer.fromJson(Map<String, dynamic> json) {
    return TripSerializer(json["arrival"], json["departure"], json["status"],
        json["available_seats"], json["id"], json["route"]);
  }
}

class CustomerTripBooking {
  final int id;
  final TripSerializer trip;
  final int numSeats;
  final int cost;
  final String status;
  CustomerTripBooking(
      this.id, this.trip, this.numSeats, this.cost, this.status);
  factory CustomerTripBooking.fromJson(Map<String, dynamic> json) {
    return CustomerTripBooking(json["id"], json["tripSerializer"],
        json["seats"], json["cost"], json["status"]);
  }
}
