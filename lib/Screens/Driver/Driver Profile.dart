import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monkez/Screens/Drawer.dart';
import 'package:monkez/misc/Image_Frame.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key key}) : super(key: key);
  static const routeName = '/driverProfile';

  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  String photo, nameDriver, phone, age, nid;
  bool isloading;

  @override
  void initState() {
    super.initState();
    isloading = true;
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      isloading = true;
    });
    String userId = FirebaseAuth.instance.currentUser.uid;
    final document = await FirebaseFirestore.instance
        .collection('drivers')
        .doc(userId)
        .get();
    photo = document.get("photoUrl");
    nameDriver = document.get('username');
    phone = document.get('mobileNumber');
    nid = document.get('National Identification Number');
    age = document.get('Age');
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.arrowRight),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.red[900],
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand'),
        ),
      ),
      drawer: MainDrawer(),
      body: (isloading == true)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      child: ImageFrame.fromNetwork(photo),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 8,
                      child: ListTile(
                        leading: Text(
                          'User Name : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        title: Text(nameDriver),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 8,
                      child: ListTile(
                        leading: Text(
                          'Age : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        title: Text(age),
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
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        title: Text(phone),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 8,
                      child: ListTile(
                        leading: Text(
                          'NID : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        title: Text(nid),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
