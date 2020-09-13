import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical/routes/home.dart';
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
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          // centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [const Color(0xFF6aa6f8), const Color(0xFF1a60be)],
              ),
            ),
          ),
          // title: Text('Title'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: HomeScreen(),
        drawer: GlobalDrawer(),
      ),
    );
  }
}
