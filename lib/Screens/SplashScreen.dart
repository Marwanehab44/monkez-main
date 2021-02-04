import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monkez/Screens/Home.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SplashScreenView(
              home: Home(),
              duration: 5000,
              imageSize: 150,
              imageSrc: "assets/images/ambulance.png",
              text: "MONKIEZ",
              textType: TextType.TyperAnimatedText,
              textStyle: TextStyle(fontSize: 30.0, letterSpacing: 5),
              colors: [
                Colors.white,
                Colors.black,
                Colors.white,
                Colors.black,
              ],
              backgroundColor: Colors.red[900],
            ),
            Container(
              height: MediaQuery.of(context).size.height *0.9,
              width: MediaQuery.of(context).size.width,
              child: TweenAnimationBuilder(
                duration: Duration(seconds: 4),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Stay Safe',
                    style: GoogleFonts.orbitron(
                      fontSize: 18,
                      color: Colors.white,
                      wordSpacing: 3,
                    ),
                  ),
                ),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (BuildContext context, double _val, Widget child) {
                  return Opacity(
                    opacity: _val,
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
