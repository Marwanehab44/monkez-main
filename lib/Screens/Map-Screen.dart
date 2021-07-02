import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:monkez/Providers/user_Provider.dart';
import 'package:monkez/Screens/Drawer.dart';
import 'package:monkez/Screens/Payment_Screen.dart';
import 'package:monkez/Screens/Transit_Screen.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isloading;
  LatLng currentPosition;
  String currentAddress;

  @override
  void initState() {
    super.initState();
    isloading = true;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    currentPosition = LatLng(_locationData.latitude, _locationData.longitude);
    currentAddress = await getAdress(currentPosition);
    setState(() {
      isloading = false;
    });
  }

  Future<String> getAdress(currentPosition) async {
    final coordinates =
        new Coordinates(currentPosition.latitude, currentPosition.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first.addressLine;
  }

  void request(LatLng pos, String address) async {
    if (mounted)
      setState(() {
        currentPosition = pos;
        currentAddress = address;
        isloading = true;
      });
    bool error = await Provider.of<UserProvider>(context, listen: false)
        .getUserLocation(currentPosition, currentAddress);
    if (!error) {
      if (mounted)
        setState(() {
          print('done');
          isloading = false;
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
          'Monkiz',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand'),
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: GradientColors.piggyPink,
              stops: [0.3, 0.9]),
        ),
        child: Stack(
          children: [
            (isloading)
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: currentPosition,
                          zoom: 14.5,
                        ),
                        myLocationEnabled: true,
                        onCameraMove: (posision) {
                          setState(() {
                            currentPosition = posision.target;
                          });
                        },
                        onCameraIdle: () async {
                          currentAddress = await getAdress(currentPosition);
                          setState(() {});
                        },
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 35 / 2),
                          child: Icon(
                            FontAwesomeIcons.mapPin,
                            size: 35,
                            color: Colors.red[900],
                          ),
                        ),
                      )
                    ],
                  ),
            Positioned(
              top: 60,
              right: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                height: 90,
                //width: double.infinity,
                child: SingleChildScrollView(
                  child: Card(
                    child: ListTile(
                      trailing: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.white,
                      ),
                      tileColor: Colors.black87,
                      leading: Text(
                        'Your Address :',
                        style: TextStyle(color: Colors.white),
                      ),
                      title: Text(
                        '$currentAddress',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 80,
              left: 50,
              bottom: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                onPressed: () {
                  request(currentPosition, currentAddress);
                 
                    Provider.of<UserProvider>(context, listen: false).getDriver(currentAddress);
                },
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Request',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
