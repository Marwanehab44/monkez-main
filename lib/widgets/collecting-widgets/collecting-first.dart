import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monkez/Screens/Auth_screen.dart';
import 'package:monkez/misc/Image_Frame.dart';
import 'package:monkez/widgets/collecting-widgets/collecting_data_title.dart';

class CollectingFirst extends StatefulWidget {
  final Function logout, nextPage;

  CollectingFirst(this.logout, this.nextPage);

  @override
  _CollectingFirstState createState() => _CollectingFirstState();
}

class _CollectingFirstState extends State<CollectingFirst> {
  File image;
  String userName, mobileNumber;
  bool isNull;
  FocusNode mobileNode;

  @override
  void initState() {
    super.initState();
    mobileNode = FocusNode();
    isNull = true;
  }

  void pickImage(bool fromGallery) async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: (fromGallery) ? ImageSource.gallery : ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  bool validData() {
    bool valid = true;
    if (image == null) valid = false;
    if (userName == null || userName.length < 3) valid = false;
    if (mobileNumber == null ||
        mobileNumber.length != 11 ||
        !mobileNumber.startsWith('01')) valid = false;

    return valid;
  }

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
                    "Welcome",
                    "Few steps to complete your profile.",
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  ImageFrame.fromFile(image),
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
                        userName = value;
                      });
                    },
                    maxLines: 1,
                    maxLength: 15,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (value) => mobileNode.requestFocus(),
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
                        mobileNumber = value;
                      });
                    },
                    focusNode: mobileNode,
                    keyboardType: TextInputType.phone,
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
                ],
              ),
            )),
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
                    widget.nextPage(image, userName, mobileNumber);
                  } else {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Invalid or Missing Data'),
                        content: Text(
                            'Please check that you have picked an Image , and the user name has at least 3 character or more and you enter a valid number'),
                        actions: [
                          FlatButton(
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
