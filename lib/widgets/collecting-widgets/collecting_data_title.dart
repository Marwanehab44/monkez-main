import 'package:flutter/material.dart';

class CollectingDataTitle extends StatelessWidget {
  final String title, body;
  CollectingDataTitle(this.title, this.body);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'AkayaKanadaka',
            ),
          ),
          Text(
            body,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'AkayaKanadaka',
            ),
          ),
        ],
      ),
    );
  }
}
