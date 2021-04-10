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
  var _value = false;
  var _value2 = false;

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
                InkWell(
                  onTap: () {},
                  child: CheckboxListTile(
                    title: Text(
                      'Pay via credit card',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    secondary: Icon(
                      Icons.credit_card,
                      color: Colors.blue[900],
                    ),
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                InkWell(
                  child: CheckboxListTile(
                    title: Text(
                      'Cash',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    secondary: Icon(
                      Icons.attach_money,
                      color: Colors.green,
                    ),
                    value: _value2,
                    onChanged: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_value2) {
                        Navigator.pushReplacementNamed(
                            context, MapScreen.routeName);
                      } else {
                        Navigator.pushReplacementNamed(
                            context, ExisitingCard.routeName);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.pink,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      primary: Colors.red[900],
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
