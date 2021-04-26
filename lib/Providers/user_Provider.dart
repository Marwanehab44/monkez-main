import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProvider with ChangeNotifier {
  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return 'wrong password.';
        case 'invalid-email':
          return 'invalid email.';
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
      File image, String userName, String mobileNumber,LatLng position,String address) async {
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
          'lat':position.latitude,
          'lng':position.longitude,
          'address':address,
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeProfile() async {
    try {
      String userId=FirebaseAuth.instance.currentUser.uid;
      final document =await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if(document.exists){
        //load data
        return true;
      }else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
