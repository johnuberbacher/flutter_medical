import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical/routes/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_medical/widgets.dart';

/// App Root
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
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
