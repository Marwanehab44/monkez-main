import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

class UserProvider with ChangeNotifier {
  var currentUser;

  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return 'invalid email or password.';
        case 'invalid-email':
          return 'invalid email or password.';
        case 'user-disabled':
          return 'This user has been disabled.';
        default:
          return 'user-not-found.';
      }
    }
  }

  Future<String> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'This email already in use';
        case 'invalid-email':
          return 'You entered invalid email';
        default:
          return 'You have entered an weak password';
      }
    }
  }

  Future<String> restPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return 'Erorr has occurred';
    }
  }

  Future<bool> updateProfile(
      File image, String userName, String mobileNumber) async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;
      final ref = FirebaseStorage.instance
          .ref('users/$userId.${image.path.split('.').last}');
      await ref.putFile(image);
      String photoUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {
          'email': email,
          'username': userName,
          'mobileNumber': mobileNumber,
          'photoUrl': photoUrl,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeProfile() async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (document.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
String addressUser;
  Future<bool> getUserLocation(LatLng position, String address) async {
    try {

      String email = FirebaseAuth.instance.currentUser.email;
      String userId = FirebaseAuth.instance.currentUser.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'lat': position.latitude,
        'lng': position.longitude,
        'address': address,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> driverProfile(
      File photo, String name, String mobNumber, String age, String id) async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;
      final ref = FirebaseStorage.instance
          .ref('drivers/$userId.${photo.path.split('.').last}');
      await ref.putFile(photo);
      String photoUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('drivers').doc(userId).set(
        {
          'email': email,
          'username': name,
          'mobileNumber': mobNumber,
          'photoUrl': photoUrl,
          'Age': age,
          'National Identification Number': id,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeDriverProfile() async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      final document = await FirebaseFirestore.instance
          .collection('drivers')
          .doc(userId)
          .get();
      if (document.exists) {
        //load data
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> getDriver(String address) async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;

      var driver;

      await FirebaseFirestore.instance
          .collection("drivers")
          .limit(1)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          driver = result.data();
        });
        print(driver['username']);
        print(driver['mobileNumber']);
        print(driver['fcmToken']);
          final body = {
            'notification': {'body': address, 'title': 'new request'},
            'priority': 'high',
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              "id": "1",
              "status": "done"
            },
            'to': driver['fcmToken'],
            //'/topics/123'
          };
          http.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAAvBZZx-w:APA91bHP-rIJkOl6jn2yP6mBqGp-7wVawxktKp3IUzpELBV2fH9TUvGwFwjWr8Ut2DT2rU0NQUhshhfYy4BGwuiruBYdszg59Qq02KINDpRD46dHnMs6Qhuusi9LdkaoNvrKEqZIQmwX',
            },
            body: jsonEncode(body),
          );
        
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

/* Future<bool> getDriverLocation(LatLng position, String address) async {
    try {
      String email = FirebaseAuth.instance.currentUser.email;
      String userId = FirebaseAuth.instance.currentUser.uid;
      await FirebaseFirestore.instance.collection('drivers').doc(userId).update({
        'lat': position.latitude,
        'lng': position.longitude,
        'address': address,
      });
      return true;
    } catch (e) {
      return false;
    }
  }*/
}
