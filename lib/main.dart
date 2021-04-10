import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monkez/Providers/user_Provider.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/Screens/Collecting_Screen.dart';
import 'package:monkez/Screens/Exisiting_Card.dart';
import 'package:monkez/Screens/Map-Screen.dart';
import 'package:monkez/Screens/Payment_Screen.dart';
import 'package:monkez/Screens/SplashScreen.dart';
import 'package:monkez/Screens/Transit_Screen.dart';
import 'package:monkez/Screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
            } else if (FirebaseAuth.instance.currentUser != null) {
              return TransitScreen();
            } else {
              return AuthScreen();
            }
          },
        ),
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          CollectingData.routeName: (context) => CollectingData(),
          TransitScreen.routName: (context) => TransitScreen(),
          MapScreen.routeName: (context) => MapScreen(),
          PaymentScreen.routeName: (context) => PaymentScreen(),
          ExisitingCard.routeName: (context) => ExisitingCard(),
        },
      ),
    );
  }
}
