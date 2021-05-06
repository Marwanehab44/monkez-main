import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monkez/Providers/user_Provider.dart';
import 'package:monkez/Screens/Transit_Screen.dart';
import 'package:monkez/widgets/auth-widgets/auth_title.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  final Function resetPassword;

  AuthForm(this.resetPassword);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  FocusNode passwordNode;
  FocusNode confirmPasswordNode;
  bool loginMood;
  TextEditingController controller1;
  TextEditingController controller2;
  bool hidePass, hideConfirmPass, loading;
  GlobalKey<FormState> form;
  double height;
  GlobalKey fieldkey;

  String email, password, confirmpassword;

  @override
  void initState() {
    super.initState();
    loginMood = true;
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
    form = GlobalKey<FormState>();
    fieldkey = GlobalKey();
    height = 0;
    hidePass = hideConfirmPass = true;
    loading = false;
    controller1 = TextEditingController();
    controller2 = TextEditingController();
  }

  void showErorr(String erorr) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(erorr),
        backgroundColor: Colors.red,
      ),
    );
  }

  void validateToLogIn() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .login(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(TransitScreen.routName);
      } else {
        setState(() {
          loading = false;
        });
        showErorr(error);
      }
    }
  }

  void validateToRegister() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .register(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(TransitScreen.routName);
      } else {
        setState(() {
          loading = false;
        });
        showErorr(error);
      }
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
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 50,
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: (loginMood)
                    ? AuthTitle(
                        UniqueKey(),
                        'Log into',
                      )
                    : AuthTitle(UniqueKey(), 'Create'),
              ),
              Form(
                key: form,
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    children: [
                      TextFormField(
                        key: fieldkey,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          passwordNode.requestFocus();
                        },
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          setState(() {
                            email = value;
                          });
                          if (EmailValidator.validate(email)) {
                            return null;
                          }
                          return "invalid email address";
                        },
                        decoration: InputDecoration(
                          hintText: 'example@abc.com',
                          errorStyle: TextStyle(color: Colors.blueGrey[900]),
                          labelText: 'Email',
                          labelStyle: GoogleFonts.libreBaskerville(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: controller1,
                        textInputAction: (loginMood)
                            ? TextInputAction.done
                            : TextInputAction.next,
                        onFieldSubmitted: (value) {
                          if (!loginMood) {
                            confirmPasswordNode.requestFocus();
                          }
                        },
                        validator: (value) {
                          setState(() {
                            password = value;
                          });
                          if (value.length >= 6) {
                            return null;
                          }
                          return 'Password must contains 6 characters at least';
                        },
                        obscureText: hidePass,
                        focusNode: passwordNode,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                hidePass = !hidePass;
                              });
                            },
                            child: (hidePass)
                                ? Icon(
                                    Icons.visibility,
                                    color: Colors.grey[900],
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey[900],
                                  ),
                          ),
                          hintText: '••••••••••',
                          labelText: 'Password',
                          errorStyle: TextStyle(color: Colors.blueGrey[900]),
                          labelStyle: GoogleFonts.libreBaskerville(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(milliseconds: 800),
                        height: (loginMood) ? 0 : height,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 600),
                          opacity: (loginMood) ? 0 : 1,
                          child: TextFormField(
                            controller: controller2,
                            validator: (value) {
                              setState(() {
                                confirmpassword = value;
                              });
                              if (loginMood || value == password) {
                                return null;
                              }
                              return 'Passwords don\'t match';
                            },
                            obscureText: hideConfirmPass,
                            focusNode: confirmPasswordNode,
                            decoration: InputDecoration(
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    hideConfirmPass = !hideConfirmPass;
                                  });
                                },
                                child: (hideConfirmPass)
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.grey[900],
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey[900],
                                      ),
                              ),
                              hintText: '••••••••••',
                              labelText: 'Confirm Password',
                              errorStyle:
                                  TextStyle(color: Colors.blueGrey[900]),
                              labelStyle: GoogleFonts.libreBaskerville(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(color: Colors.black),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              if (loginMood)
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.white.withOpacity(0.2),
                    onPressed: () {
                      widget.resetPassword();
                    },
                    child: Text(
                      'Forget Password?',
                      style: GoogleFonts.libreBaskerville(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              Container(
                height: MediaQuery.of(context).size.height * 0.070,
                width: double.infinity,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  splashColor: Colors.red,
                  highlightElevation: 12,
                  highlightColor: Colors.red[900],
                  color: Colors.black,
                  onPressed: () {
                    if (loginMood) {
                      validateToLogIn();
                    } else {
                      validateToRegister();
                    }
                  },
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: (loginMood)
                        ? Text(
                            'Login',
                            style: GoogleFonts.libreBaskerville(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            key: UniqueKey(),
                          )
                        : Text(
                            'Register',
                            style: GoogleFonts.libreBaskerville(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            key: UniqueKey(),
                          ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: (loginMood)
                      ? Row(
                          key: UniqueKey(),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.libreBaskerville(fontSize: 16),
                            ),
                            FlatButton(
                              highlightColor: Colors.white.withOpacity(0.1),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                final state = fieldkey.currentContext;
                                final box =
                                    state.findRenderObject() as RenderBox;
                                setState(() {
                                  loginMood = !loginMood;

                                  height = box.size.height;
                                });
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.libreBaskerville(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        )
                      : Row(
                          key: UniqueKey(),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.libreBaskerville(fontSize: 16),
                            ),
                            FlatButton(
                              highlightColor: Colors.white.withOpacity(0.1),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  loginMood = !loginMood;
                                });
                              },
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.libreBaskerville(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
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
