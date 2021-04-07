import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/misc/Image_Frame.dart';
import 'package:monkez/widgets/collecting-widgets/collecting_data_title.dart';

class CollectingSecond extends StatefulWidget {
  final Function submit;
  final File image;
  final String name,num;
  CollectingSecond(this.image,this.name,this.num,this.submit);

  @override
  _CollectingSecondState createState() => _CollectingSecondState();
}

class _CollectingSecondState extends State<CollectingSecond> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CollectingDataTitle(
                  "Finally Done",
                  "Is everything okay ? ",
                ),
                SizedBox(
                  height: 50,
                ),
                ImageFrame.fromFile(widget.image),
                SizedBox(
                  height: 50,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  child: ListTile(
                    leading: Text(
                      'Name : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AkayaKanadaka',
                      ),
                    ),
                    title: Text(widget.name),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  child: ListTile(
                    leading: Text(
                      'E-mail : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AkayaKanadaka',
                      ),
                    ),
                    title: Text(FirebaseAuth.instance.currentUser.email),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  child: ListTile(
                    leading: Text(
                      'Mobile Number : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AkayaKanadaka',
                      ),
                    ),
                    title: Text(widget.num),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          color: Colors.black,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthScreen()),
                            );
                          },
                        ),
                        FlatButton(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          color: Colors.black,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          onPressed: () {
                            widget.submit();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
