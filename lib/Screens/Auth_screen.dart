import 'package:flutter/material.dart';
import 'package:monkez/widgets/auth-widgets/auth_background.dart';
import 'package:monkez/widgets/auth-widgets/auth_form.dart';
import 'package:monkez/widgets/auth-widgets/reset_password_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = 'auth-screen';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AuthScreen> {
  bool forgotPass;

  @override
  void initState() {
    super.initState();
    forgotPass = false;
  }

  void toggleReset() {
    setState(() {
      forgotPass = !forgotPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthBackground(),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            right: (forgotPass) ? 0 : -MediaQuery.of(context).size.width,
            child: ResetPasswordForm(toggleReset),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            left: (!forgotPass) ? 0 : -MediaQuery.of(context).size.width,
            child: AuthForm(toggleReset),
          )
        ],
      ),
    );
  }
}
