import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monkez/Screens/Drawer.dart';
import 'package:monkez/misc/Image_Frame.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key key}) : super(key: key);
  static const routeName = '/userprofile';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String img,name,mob;
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
    final document =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    img = document.get("photoUrl");
    name=document.get('username');
    mob=document.get('mobileNumber');
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
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                      child: ImageFrame.fromNetwork(img),
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
                      title: Text(name),
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
                      title: Text(mob),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
