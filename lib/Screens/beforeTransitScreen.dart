import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:monkez/Screens/Driver/transit_driver_screen.dart';
import 'package:monkez/Screens/Transit_Screen.dart';

class BeforeTransite extends StatelessWidget {
  static const String routeName = '/before-transit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: GradientColors.piggyPink,
                stops: [0.3, 0.9]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'continue as a Driver ?',
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black87,
                    elevation: 8,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, TransitDriverScreen.routName);
                },
                child: Text(
                  'As a Captain',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'continue as a User ?',
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[900],
                    elevation: 15,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, TransitScreen.routName);
                },
                child: Text(
                  'As a User',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
