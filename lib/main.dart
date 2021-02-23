import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/Screens/Collecting_Screen.dart';
import 'package:monkez/Screens/SplashScreen.dart';
import 'package:monkez/Screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monkz',
      theme: ThemeData(
        primaryColor: Colors.red,
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return SplashScreen();
          }
        },
      ),
      routes: {
        AuthScreen.routeName: (context) => AuthScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CollectingData.routeName: (context) => CollectingData(),
      },
    );
  }
}
