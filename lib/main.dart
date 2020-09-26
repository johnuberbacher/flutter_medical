import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical/routes/home.dart';
import 'package:flutter_medical/routes/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_medical/widgets.dart';

/// App Root
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: "Flutter Medical",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // TODO delete these when done with sign in and sign up
        appBar: GlobalAppBar(),
        drawer: GlobalDrawer(),
        body: SignUpPage(),
      ),
    );
  }
}
