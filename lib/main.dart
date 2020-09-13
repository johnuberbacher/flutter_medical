import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical/routes/home.dart';
import 'package:flutter_medical/routes/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_medical/widgets.dart';

/// App Root
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
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
    return MaterialApp(
      title: "Flutter Medical",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: GlobalAppBar(),
        drawer: GlobalDrawer(),
        body: HomeScreen(),
      ),
    );
  }
}
