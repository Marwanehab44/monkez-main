import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool help;

  @override
  void initState() {
    super.initState();
    help = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.pink[100],
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(25.0),
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
              SizedBox(height: 30,),
              InkWell(
                onTap: (){},
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
