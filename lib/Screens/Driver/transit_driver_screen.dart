import 'package:flutter/material.dart';
import 'package:monkez/Providers/user_Provider.dart';
import 'package:monkez/Screens/Driver/collecting_driver_screen.dart';
import 'package:monkez/Screens/SplashScreen.dart';
import 'package:monkez/Screens/home_screen.dart';
import 'package:monkez/Screens/pre_collecting.dart';
import 'package:provider/provider.dart';


class TransitDriverScreen extends StatelessWidget {
  static const routName='/transit-Driver-Screen';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
      Provider.of<UserProvider>(context, listen: false).completeDriverProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else if (snapshot.data == true) {
          return HomeScreen();
        } else {
          return CollectingDriverScreen();
        }
      },
    );
  }
}
