import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/misc/Image_Frame.dart';
import 'package:monkez/widgets/collecting-widgets/collecting_data_title.dart';

class CollectingFirstDriver extends StatefulWidget {
  final Function logout, nextPage;

  CollectingFirstDriver(
    this.logout,
    this.nextPage,
  );

  @override
  _CollectingFirstDriverState createState() => _CollectingFirstDriverState();
}

class _CollectingFirstDriverState extends State<CollectingFirstDriver> {
  File photo;
  String name, mobNumber, age, egyId;
  bool isNull;

  @override
  void initState() {
    super.initState();
    isNull = true;
  }

  void pickImage(bool fromGallery) async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: (fromGallery) ? ImageSource.gallery : ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        photo = File(pickedImage.path);
      });
    }
  }

  bool validData() {
    bool valid = true;
    if (photo == null) valid = false;
    if (name == null || name.length < 3) valid = false;
    if (mobNumber == null ||
        mobNumber.length != 11 ||
        !mobNumber.startsWith('01')) valid = false;
    if (egyId == null || egyId.length != 14 || !egyId.startsWith("2"))
      valid = false;

    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CollectingDataTitle(
                    "Welcome",
                    "Few steps to complete your profile.",
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ImageFrame.fromFile(photo),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton.icon(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        icon: Icon(
                          Icons.photo_library_rounded,
                          color: Colors.red,
                        ),
                        label: Text(
                          'Gallery',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          pickImage(true);
                        },
                      ),
                      RaisedButton.icon(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.red,
                        ),
                        label: Text(
                          'Camera',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          pickImage(false);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        labelText: 'User Name',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'AkayaKanadaka',
                        ),
                        hintText: 'example: Mohamed '),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        mobNumber = value;
                      });
                    },
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'AkayaKanadaka',
                        ),
                        hintText: 'example: 01xxxxxxxxx '),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        age = value;
                      });
                    },
                    maxLines: 1,
                    maxLength: 2,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        labelText: 'Your Age',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'AkayaKanadaka',
                        ),
                        hintText: 'example: 22 '),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        egyId = value;
                      });
                    },
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black87,
                            width: 3,
                          ),
                        ),
                        labelText: 'National id number',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'AkayaKanadaka',
                        ),
                        hintText: 'example: 2xxxxxxxxxxxxx '),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                elevation: 5,
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
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onPressed: () async {
                  if (await widget.logout()) {
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName);
                  }
                },
              ),
              RaisedButton(
                elevation: 5,
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
                    "Next",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onPressed: () {
                  if (validData()) {
                    widget.nextPage(photo, name, mobNumber, age, egyId);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Invalid or Missing Data'),
                        content: Text('Please fill your data correctly'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Ok')),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
