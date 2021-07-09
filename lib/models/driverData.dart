import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverData {
  String photoUrl, userName, userId, email, mobileNumber, address,nid;
  LatLng position;

  DriverData.fromFirestore(this.userId, document,this.email)
      :
        this.userName = document['userName'],
        this.address = document['address'],
        this.mobileNumber = document['mobileNumber'],
        this.photoUrl = document['photoUrl'],
        this.nid=document["nid"];
}
