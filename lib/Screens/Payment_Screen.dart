import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:monkez/Screens/Exisiting_Card.dart';
import 'package:monkez/Screens/Map-Screen.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment-screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int radioButton;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: GradientColors.piggyPink,
            stops: [0.3, 0.9],
          )),
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text(
                  "Please choose the method that you want",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                Center(
                  child: Card(
                    elevation: 25,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pushReplacementNamed(
                                  context, ExisitingCard.routeName);
                            });
                          },
                          child: ListTile(
                            title: Text(
                              'Pay via credit card',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                            leading: Icon(
                              Icons.credit_card,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pushReplacementNamed(
                                  context, MapScreen.routeName);
                            });
                          },
                          child: ListTile(
                            title: Text(
                              'Cash',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                            leading: Icon(
                              Icons.attach_money,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
