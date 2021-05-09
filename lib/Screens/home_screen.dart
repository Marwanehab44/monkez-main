import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monkez/Screens/Map-Screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

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
            children: [
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.red[900],
                  highlightColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      'Monkiz',
                      style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand'),
                    ),
                  ),
                ),
              ),
              Image(
                image: AssetImage('assets/images/homeScreenAmbulance.png'),
              ),
              Text(
                'Request for an Ambulance !!',
                style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MapScreen()));
                },
                child: Card(
                  color: Colors.red[900],
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50)
                        .add(EdgeInsets.symmetric(vertical: 15)),
                    child: Icon(
                      FontAwesomeIcons.longArrowAltRight,
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
