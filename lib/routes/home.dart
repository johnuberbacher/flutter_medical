import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_medical/routes/functions.dart';
import 'package:flutter_medical/services/shared_preferences.dart';
import 'package:flutter_medical/widgets.dart';
import 'package:flutter_medical/main.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/routes/profile.dart';
import 'package:flutter_medical/routes/category.dart';
import 'package:flutter_medical/routes/myHealth.dart';
import 'package:flutter_medical/routes/search.dart';
import 'package:flutter_medical/models/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

DocumentSnapshot snapshot;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _launched;
  String _phone = '123-456-7890';
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorSnapshot;
  QuerySnapshot specialtySnapshot;
  QuerySnapshot doctorSpecialtyCount;
  QuerySnapshot userProfileSnapshot;
  List<DocumentSnapshot> loadedDoctors = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 3;
  DocumentSnapshot lastDocument;

  getDoctors() async {
    databaseMethods.getAllDoctors().then((val) {
      print(val.toString());
      setState(() {
        doctorSnapshot = val;
        print(doctorSnapshot);
      });
    });
  }

  paginateDoctors() async {
    if (!hasMore) {
      print('No More Products');
      return;
    }
    if (isLoading) {
      return;
    }
    if (lastDocument == null) {
      databaseMethods.getAllDoctorsPagination(documentLimit).then((val) {
        setState(() {
          doctorSnapshot = val;
          print(
              "pulling doctors without having loaded any more, Document Limit is:");
          print(documentLimit);
          setState(() {
            isLoading = false;
          });
        });
      });
    } else {
      databaseMethods
          .getAllDoctorsPaginationStartAfter(documentLimit, lastDocument)
          .then((val) {
        setState(() {
          doctorSnapshot = val;
          print("pulling NEW doctors, lastDocuments is:");
          print(lastDocument);
          setState(() {
            isLoading = false;
          });
        });
      });
    }
    if (doctorSnapshot.docs.length < documentLimit) {
      hasMore = false;
    }
    lastDocument = doctorSnapshot.docs[doctorSnapshot.docs.length - 1];
    loadedDoctors.addAll(doctorSnapshot.docs);
    setState(() {
      isLoading = false;
    });
  }

  void setLoading([bool value = false]) => setState(() {
        isLoading = value;
      });

  getSpecialties() async {
    databaseMethods.getAllSpecialties().then((val) {
      print(val.toString());
      setState(() {
        specialtySnapshot = val;
        print(specialtySnapshot);
      });
    });
  }

  Widget loadUserInfo() {
    return userProfileSnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: userProfileSnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return userHeader(
                    imagePath:
                        userProfileSnapshot.docs[index].data()["imagePath"],
                  );
                }),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [
                  const Color(0xFF6aa6f8),
                  const Color(0xFF1a60be),
                ], // whitish to gray
              ),
            ),
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
  }

  Widget userHeader({
    String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 25.0,
            ),
            width: 70.0,
            height: 70.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new CachedNetworkImageProvider(
                    imagePath ?? "https://i.imgur.com/iQkzaTO.jpg"),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    'Welcome back, ' + titleCase(Constants.myName),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.25,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: Text(
                      'How can we help you today?',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget doctorList() {
    return doctorSnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: doctorSnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return doctorCard(
                    name: doctorSnapshot.docs[index].data()["name"],
                    specialty: doctorSnapshot.docs[index].data()["specialty"],
                    imagePath: doctorSnapshot.docs[index].data()["imagePath"],
                    rank: doctorSnapshot.docs[index].data()["rank"],
                  );
                }),
          )
        : Container(
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 20.0,
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget specialtyList() {
    return specialtySnapshot != null
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: specialtySnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return specialtyCard(
                specialtyName:
                    specialtySnapshot.docs[index].data()["specialtyName"],
                specialtyDoctorCount: specialtySnapshot.docs[index]
                    .data()["specialtyDoctorCount"],
                specialtyImagePath:
                    specialtySnapshot.docs[index].data()["specialtyImagePath"],
              );
            })
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget specialtyCard(
      {String specialtyName,
      String specialtyDoctorCount,
      String specialtyImagePath}) {
    return Material(
      color: const Color(0xFFFFFFFF),
      child: Container(
        margin: const EdgeInsets.only(
          left: 20.0,
          right: 0.0,
        ),
        width: 130,
        height: 100,
        child: Card(
          elevation: 3.0,
          child: new InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryPage(specialtyName)),
              );
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 5.0,
                            bottom: 12.5,
                          ),
                          child: Image.network(
                            specialtyImagePath,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      specialtyName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6f6f6f),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 3.0,
                      ),
                      child: Text(
                        specialtyDoctorCount + ' Doctors',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF9f9f9f),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget doctorCard(
      {String name, String specialty, String imagePath, String rank}) {
    return Material(
      color: const Color(0xFFFFFFFF),
      child: Container(
        margin: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 10.0,
        ),
        child: Card(
          elevation: 3.0,
          child: new InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(name),
                  ));
            },
            child: Container(
              child: Align(
                alignment: FractionalOffset.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          right: 20.0,
                        ),
                        width: 70.0,
                        height: 70.0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              CachedNetworkImageProvider(imagePath),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: FractionalOffset.centerLeft,
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Align(
                              alignment: FractionalOffset.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                child: Text(
                                  specialty,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9f9f9f),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: FractionalOffset.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                child: Text(
                                  rank + "  ⭐ ⭐ ⭐ ⭐ ⭐",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF6f6f6f),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  viewDoctorProfile({String name}) {
    DatabaseMethods().getDoctorProfile(name);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ProfilePage(name)));
  }

  @override
  void initState() {
    getUserInfo();
    getSpecialties();
    paginateDoctors();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await CheckSharedPreferences.getNameSharedPreference();
    setState(() {
      print("Shared Preferences: users name: ${Constants.myName}");
    });
    databaseMethods.getUserProfile(Constants.myName).then((val) {
      print(val.toString());
      setState(() {
        userProfileSnapshot = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      drawer: GlobalDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                const Color(0xFF6aa6f8),
                const Color(0xFF1a60be)
              ], // whitish to gray
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              loadUserInfo(),
              Container(
                margin: const EdgeInsets.only(
                  top: 40.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              MaterialButton(
                                onPressed: () => setState(() {
                                  initiatePhoneCall('tel:$_phone');
                                }),
                                color: Color(0xFF4894e9),
                                highlightColor: Color(0xFF89b9f0),
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.phone,
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(
                                  'Consultation',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF6f6f6f),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchPage()),
                                  );
                                },
                                color: Color(0xFF4894e9),
                                highlightColor: Color(0xFF89b9f0),
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.people,
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(
                                  'Doctor Lookup',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF6f6f6f),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    SlideRightRoute(
                                        page: MyHealthPage(Constants.myName)),
                                  );
                                },
                                color: Color(0xFF4894e9),
                                highlightColor: Color(0xFF89b9f0),
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(
                                  'My Health',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF6f6f6f),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    sectionTitle("Specialties"),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 15.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                          style: TextStyle(
                            color: Color(0xFF9f9f9f),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 160,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          specialtyList(),
                        ],
                      ),
                    ),
                    sectionTitle("Our Top Doctors"),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 15.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                          style: TextStyle(
                            color: Color(0xFF9f9f9f),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          loadedDoctors.length == null
                              ? Center(
                                  child: Text('No More Data to load...'),
                                )
                              : ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: loadedDoctors.length,
                                  itemBuilder: (context, index) {
                                    return doctorCard(
                                      name: doctorSnapshot.docs[index]
                                          .data()["name"],
                                      specialty: doctorSnapshot.docs[index]
                                          .data()["specialty"],
                                      imagePath: doctorSnapshot.docs[index]
                                          .data()["imagePath"],
                                      rank: doctorSnapshot.docs[index]
                                          .data()["rank"],
                                    );
                                  },
                                ),
                          isLoading
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(5),
                                  color: Colors.yellowAccent,
                                  child: Text(
                                    'Loading',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 20.0,
                      ),
                      child: new OutlineButton(
                        color: Colors.transparent,
                        splashColor: Color(0xFF4894e9),
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          paginateDoctors();
                        },
                        textColor: Color(0xFF4894e9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'View More',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
