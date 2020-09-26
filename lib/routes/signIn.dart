import 'package:flutter/material.dart';
import 'package:flutter_medical/routes/signUp.dart';
import 'package:flutter_medical/widgets.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: GlobalAppBar(),
        drawer: GlobalDrawer(),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: SingleChildScrollView(
            child: Container(
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
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              left: 40.0,
                              right: 40.0,
                            ),
                            child: Text(
                              'Lorem ipsum dolor sit amet, aliqua consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore. ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, 60.0, 0.0),
                          margin: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
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
                                margin: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0,
                                ),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.none,
                                  decoration: InputDecoration(
                                    hintText: 'email@emailaddress.com',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFb1b2c4),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF6aa6f8), width: 0.0),
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 20.0,
                                        left: 10.0,
                                        bottom: 1.0,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFF6aa6f8),
                                      ),
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
                                  textCapitalization: TextCapitalization.none,
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFb1b2c4),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF6aa6f8), width: 0.0),
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 20.0,
                                        left: 10.0,
                                        bottom: 1.0,
                                      ),
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: Color(0xFF6aa6f8),
                                      ),
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
                        print('Sign In Clicked');
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign In',
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
                          'Need an account? Create one instead.',
                          style: TextStyle(
                              color: Color(0xFF4894e9),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
