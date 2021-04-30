import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //AnimationController _controller;
/*
  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }
*/
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.red[900],
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/ambulance.png",
                      height: 150,
                      width: 150,
                    ),
                    Text(
                      'MONKIZ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
