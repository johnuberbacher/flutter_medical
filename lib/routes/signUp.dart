import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_medical/routes/home.dart';
import 'package:flutter_medical/routes/signIn.dart';
import 'package:flutter_medical/services/authenticate.dart';
import 'package:flutter_medical/services/authentication.dart';
import 'package:flutter_medical/services/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_medical/widgets.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;
  SignUpPage(this.toggleView);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController userNameLowercaseTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signUpAccount() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      HelperFunctions.saveUserNamePreference(
          userNameTextEditingController.text);
      HelperFunctions.saveUserEmailPreference(emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        // print("${val.uid}");

        databaseMethods.setUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.75,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-1.0, 0.0),
                          end: Alignment(1.0, 0.0),
                          colors: [
                            const Color(0xFF6aa6f8),
                            const Color(0xFF1a60be)
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 15.0,
                              right: 40.0,
                              left: 40.0,
                            ),
                            child: Text(
                              'Lorem ipsum dolor sit amet, aliqua consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore. ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, 60.0, 0.0),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              color: Color(0xFFFFFFFF),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 50.0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(20.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Please enter a valid email address";
                                    },
                                    controller: emailTextEditingController,
                                    textCapitalization: TextCapitalization.none,
                                    decoration: InputDecoration(
                                      hintText: 'email@address.com',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFb1b2c4),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.05),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 25.0,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.alternate_email,
                                        color: Color(0xFF6aa6f8),
                                      ),
                                      //
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 20.0,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Password must be greater than 6 characters";
                                    },
                                    controller: passwordTextEditingController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFb1b2c4),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.05),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 25.0,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Color(0xFF6aa6f8),
                                      ),
                                      //
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 90.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: RaisedButton(
                        color: Color(0xFF4894e9),
                        padding: EdgeInsets.all(15),
                        onPressed: () {
                          signUpAccount();
                        },
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Already have an account? Sign In instead.',
                            style: TextStyle(
                                color: Color(0xFF4894e9),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          widget.toggleView();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
