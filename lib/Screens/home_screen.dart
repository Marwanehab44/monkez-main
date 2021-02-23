import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monkez/Screens/Auth_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MONKIZ'),
        centerTitle: true,
      ),
      body: FlatButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        },
        child: Center(child: Text('logout')),
      ),
    );
  }
}
