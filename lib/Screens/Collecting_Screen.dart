import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monkez/Providers/user_Provider.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/Screens/Transit_Screen.dart';
import 'package:monkez/widgets/collecting-widgets/collecting-first.dart';
import 'package:monkez/widgets/collecting-widgets/collecting-second.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class CollectingData extends StatefulWidget {
  static const String routeName = '/collecting';

  @override
  _CollectingDataState createState() => _CollectingDataState();
}

class _CollectingDataState extends State<CollectingData> {
  String currentAddress,name, number;
  LatLng currentCoordinates;
  File pickedImage;
  PageController controller;
  bool loading;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    loading = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submit(LatLng pos,String address) async {
    setState(() {
      currentCoordinates=pos;
      currentAddress=address;
      loading = true;
    });
    bool error = await Provider.of<UserProvider>(context, listen: false)
        .updateProfile(pickedImage, name, number, currentCoordinates,currentAddress);
    if (!error) {
      setState(() {
        loading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error has occurred'), 
          content: Text('Please try again later'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok')),
          ],
        ),
      );
    } else {
      Navigator.of(context).pushReplacementNamed(TransitScreen.routName);
    }
  }

  Future<bool> logout() async {
    bool action = await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Are you sure ?'),
        content: Text(
          'by logging out you will be asked the same information in your next login',
        ),
        actions: [
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          FlatButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    );
    return action;
  }

  void nextPage(File image, String userName, String mobNum) {
    setState(() {
      this.pickedImage = image;
      this.name = userName;
      this.number = mobNum;
    });
    controller.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        bool action = await logout();
        if (action == true) {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
                child: Container(
                  height: height - MediaQuery.of(context).padding.top - 20,
                  width: width,
                  child: PageIndicatorContainer(
                    length: 2,
                    padding: EdgeInsets.only(bottom: 30),
                    indicatorColor: Colors.grey,
                    indicatorSelectorColor: Colors.black,
                    shape: IndicatorShape.roundRectangleShape(
                      size: Size(20, 5),
                      cornerSize: Size.square(20),
                    ),
                    child: PageView(
                      controller: controller,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CollectingFirst(logout, nextPage),
                        CollectingSecond(pickedImage, name, number, submit),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (loading)
              Container(
                height: height,
                width: width,
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
