import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/Screens/Payment_Screen.dart';
import 'package:monkez/Screens/home_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: GradientColors.piggyPink,
                stops: [0.3, 0.9]),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser.email,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
                  },
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(
                        context, AuthScreen.routeName);
                  },
                  title: Text(
                    'Log out',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, PaymentScreen.routeName);
                  },
                  title: Text(
                    'Payment',
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(
                    Icons.attach_money,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
