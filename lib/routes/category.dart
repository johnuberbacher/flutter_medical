import 'package:flutter/material.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/routes/profile.dart';
import 'package:flutter_medical/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class CategoryPage extends StatefulWidget {
  final String specialty;
  CategoryPage(this.specialty);

  @override
  CategoryPageState createState() => CategoryPageState(specialty);
}

class CategoryPageState extends State<CategoryPage> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorSnapshot;
  QuerySnapshot specialtySnapshot;
  String specialty;
  CategoryPageState(this.specialty);
  bool descTextShowFlag = false;

  getDoctors() async {
    databaseMethods.getDoctorBySpecialty(specialty).then((val) {
      setState(() {
        doctorSnapshot = val;
        print(doctorSnapshot);
      });
    });
  }

  getSpecialtyInfo() async {
    databaseMethods.getSpecialty(specialty).then((val) {
      setState(() {
        specialtySnapshot = val;
        print(specialtySnapshot);
      });
    });
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
            child: Text("error"),
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
                          backgroundImage: NetworkImage(imagePath),
                        ),
                      ),
                      Container(
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

  Widget specialtyInfo() {
    return specialtySnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: specialtySnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return doctorCard(
                    specialtyDoctorCount: specialtySnapshot.docs[index]
                        .data()["specialtyDoctorCount"],
                    specialtyImagePath: specialtySnapshot.docs[index]
                        .data()["specialtyImagePath"],
                    specialtyName:
                        specialtySnapshot.docs[index].data()["specialtyName"],
                  );
                }),
          )
        : Container(
            child: Text("error"),
          );
  }

  @override
  void initState() {
    getDoctors();
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
                const Color(0xFF1a60be),
              ], // whitish to gray
            ),
          ),
          alignment: Alignment.center, // where to position the child
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 15.0,
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
                      //transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -15.0, 0.0),
                                child: Material(
                                  elevation: 0.0,
                                  clipBehavior: Clip.hardEdge,
                                  color: Colors.transparent,
                                  child: Ink.image(
                                    image: AssetImage(
                                        'assets/images/category-banner.jpg'),
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height: 150.0,
                                    child: InkWell(
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 20.0,
                        left: 20.0,
                        bottom: 15.0,
                        top: 15.0,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              specialty ?? "not found",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Color(0xFF6f6f6f),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pharetra convallis posuere morbi leo urna molestie. Odio aenean sed adipiscing diam donec adipiscing. Volutpat maecenas volutpat blandit aliquam etiam erat. Vel pretium lectus quam id. In ante metus dictum at tempor commodo ullamcorper. Sed faucibus turpis in eu mi bibendum neque.',
                          style: TextStyle(
                            color: Color(0xFF9f9f9f),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      child: new OutlineButton(
                        color: Colors.transparent,
                        splashColor: Color(0xFF4894e9),
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          getDoctors();
                          print('View All Doctors Clicked');
                        },
                        textColor: Color(0xFF4894e9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Read More',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20.0,
                        left: 20.0,
                        right: 15.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Our Top Doctors in $specialty' ?? "not found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFF6f6f6f),
                          ),
                        ),
                      ),
                    ),
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
                    doctorSnapshot != null
                        ? Container(
                            child: ListView.builder(
                                reverse: true,
                                itemCount: doctorSnapshot.docs.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
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
                                }),
                          )
                        : Container(
                            child: Text("error"),
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
