import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monkez/Providers/user_Provider.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/Screens/Collecting_Screen.dart';
import 'package:monkez/Screens/Driver/Driver%20Profile.dart';
import 'package:monkez/Screens/Driver/collecting_driver_screen.dart';
import 'package:monkez/Screens/Driver/map_screen_driver.dart';
import 'package:monkez/Screens/Driver/transit_driver_screen.dart';
import 'package:monkez/Screens/Exisiting_Card.dart';
import 'package:monkez/Screens/Map-Screen.dart';
import 'package:monkez/Screens/Payment_Screen.dart';
import 'package:monkez/Screens/SplashScreen.dart';
import 'package:monkez/Screens/Transit_Screen.dart';
import 'package:monkez/Screens/UserProfile.dart';
import 'package:monkez/Screens/home_screen.dart';
import 'package:monkez/Screens/pre_collecting.dart';
import 'package:provider/provider.dart';

import 'Screens/beforeTransitScreen.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  PaymentScreen();
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await FCMConfig.instance.init(onBackgroundMessage:_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        Navigator.of(context).pushReplacementNamed(MapScreenDriver.routeName);
      }
    });



    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.of(context).pushReplacementNamed(MapScreenDriver.routeName);
    });
  }

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
              return BeforeTransite();
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
          PreCollecting.routeName: (context) => PreCollecting(),
          CollectingDriverScreen.routeName: (context) =>
              CollectingDriverScreen(),
          TransitDriverScreen.routName: (context) => TransitDriverScreen(),
          BeforeTransite.routeName: (context) => BeforeTransite(),
          UserProfile.routeName:(context)=>UserProfile(),
          DriverProfile.routeName:(context)=>DriverProfile(),
        },
      ),
    );
  }
}
