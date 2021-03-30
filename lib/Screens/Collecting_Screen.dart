import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/widgets/collecting-widgets/collecting-first.dart';
import 'package:monkez/widgets/collecting-widgets/collecting-second.dart';
import 'package:page_indicator/page_indicator.dart';

class CollectingData extends StatefulWidget {
  static const String routeName = '/collecting';

  @override
  _CollectingDataState createState() => _CollectingDataState();
}

class _CollectingDataState extends State<CollectingData> {
  String name, number;
  File pickedImage;
  PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submit(){

  }
  Future<bool> logout() async {
    bool action = await showDialog(
      context: context,
      child: AlertDialog(
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
        body: Container(
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
                    CollectingSecond(pickedImage,name,number),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
