import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.0, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [const Color(0xFF6aa6f8), const Color(0xFF1a60be)],
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
                                      color: Colors.transparent, width: 0.0),
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
                                      color: Colors.transparent, width: 0.0),
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
                    print('View All Doctors Clicked');
                  },
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create Account',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
