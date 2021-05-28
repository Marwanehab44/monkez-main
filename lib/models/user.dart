import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String photoUrl, userName, userId, email, mobileNumber, address;
  LatLng position;

  User.fromFirestore(this.userId, document)
      : this.email = document['email'],
        this.userName = document['userName'],
        this.address = document['address'],
        this.mobileNumber = document['mobileNumber'],
        this.photoUrl = document['photoUrl'],
        this.position = LatLng(document['lat'], document['lng']);
}
