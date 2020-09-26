import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_medical/routes/signIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
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
                key: _formKey,
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
                            transform:
                                Matrix4.translationValues(0.0, 60.0, 0.0),
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
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Provide an email';
                                      }
                                    },
                                    onSaved: (input) => _email = input,
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
                                            color: Color(0xFF6aa6f8),
                                            width: 0.0),
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
                                    validator: (input) {
                                      if (input.length < 6) {
                                        return 'Longer password please';
                                      }
                                    },
                                    onSaved: (input) => _password = input,
                                    obscureText: true,
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
                                            color: Color(0xFF6aa6f8),
                                            width: 0.0),
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
                          signUp();
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                          );
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
