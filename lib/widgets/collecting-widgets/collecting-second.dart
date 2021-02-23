import 'package:flutter/material.dart';
import 'package:monkez/widgets/collecting-widgets/collecting_data_title.dart';

class CollectingSecond extends StatefulWidget {
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
                  "One Step Left",
                  "Select your current location ",
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
                          onPressed: () {},
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
                          onPressed: () {},
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
