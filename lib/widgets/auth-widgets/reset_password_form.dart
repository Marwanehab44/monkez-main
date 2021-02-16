import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth_title.dart';

class ResetPasswordForm extends StatefulWidget {
  final Function resetPassword;
  ResetPasswordForm(this.resetPassword);
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  GlobalKey<FormState> form;
  String email;
  bool loading;
  @override
  void initState() {
    super.initState();
    form = GlobalKey<FormState>();
    loading = false;
  }

  void showErorr(String erorr) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(erorr),
        backgroundColor: Colors.red,
      ),
    );
  }

  void validateToResetPassword() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Email has been sent.'),
          ),
        );
      } on FirebaseException catch (e) {
        showErorr('Erorr has occurred');
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40).add(
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(UniqueKey(), 'Reset Password of'),
              Form(
                key: form,
                child: TextFormField(
                  validator: (value) {
                    setState(() {
                      email = value;
                    });
                    if (EmailValidator.validate(email)) {
                      return null;
                    }
                    return 'Please enter your Email';
                  },
                  decoration: InputDecoration(
                    hintText: 'example@abc.com',
                    labelText: 'Email',
                    labelStyle: GoogleFonts.libreBaskerville(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02),
                height: MediaQuery.of(context).size.height * 0.065,
                width: double.infinity,
                child: (loading)
                    ? Center(child: CircularProgressIndicator())
                    : RaisedButton(
                        shape: StadiumBorder(),
                        splashColor: Colors.red,
                        highlightElevation: 12,
                        highlightColor: Colors.red[900],
                        color: Colors.black,
                        onPressed: () {
                          validateToResetPassword();
                        },
                        child: Text(
                          'Reset Password',
                          style: GoogleFonts.libreBaskerville(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          key: UniqueKey(),
                        ),
                      ),
              ),
              Center(
                child: FlatButton(
                  shape: StadiumBorder(),
                  splashColor: Colors.red,
                  highlightColor: Colors.red[900],
                  color: Colors.black,
                  onPressed: () {
                    widget.resetPassword();
                  },
                  child: Text(
                    'cancel',
                    style: GoogleFonts.libreBaskerville(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
