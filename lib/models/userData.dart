import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserData {
  String photoUrl, userName, userId, email, mobileNumber, address;
  LatLng position;

  UserData.fromFirestore(this.userId, document, this.email)
      : this.userName = document['userName'],
        this.address = document['address'],
        this.mobileNumber = document['mobileNumber'],
        this.photoUrl = document['photoUrl'],
        this.position = LatLng(document['lat'], document['lng']);
}
