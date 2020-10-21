import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/routes/category.dart';
import 'package:flutter_medical/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class ProfilePage extends StatefulWidget {
  final String name;
  ProfilePage(this.name);

  @override
  _ProfilePageState createState() => _ProfilePageState(name);
}

class _ProfilePageState extends State<ProfilePage> {
  String name;
  _ProfilePageState(this.name);
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorProfileSnapshot;

  getProfile(name) async {
    print(name);
    databaseMethods.getDoctorProfile(name).then((val) {
      print(val.toString());
      setState(() {
        doctorProfileSnapshot = val;
        print(doctorProfileSnapshot);
      });
    });
  }

  @override
  void initState() {
    getProfile(name);
  }

  Widget doctorProfile() {
    return doctorProfileSnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: doctorProfileSnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return doctorCard(
                    name: doctorProfileSnapshot.docs[index].data()["name"],
                    specialty:
                        doctorProfileSnapshot.docs[index].data()["specialty"],
                    imagePath:
                        doctorProfileSnapshot.docs[index].data()["imagePath"],
                    rank: doctorProfileSnapshot.docs[index].data()["rank"],
                    medicalEducation: doctorProfileSnapshot.docs[index]
                        .data()["medicalEducation"],
                    residency:
                        doctorProfileSnapshot.docs[index].data()["residency"],
                    internship:
                        doctorProfileSnapshot.docs[index].data()["internship"],
                    fellowship:
                        doctorProfileSnapshot.docs[index].data()["fellowship"],
                    biography:
                        doctorProfileSnapshot.docs[index].data()["biography"],
                  );
                }),
          )
        : Container(
            child: Text("error"),
          );
  }

  Widget doctorCard({
    String name,
    String specialty,
    String imagePath,
    String rank,
    String medicalEducation,
    String residency,
    String internship,
    String fellowship,
    String biography,
  }) {
    return Container(
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
                          MaterialButton(
                            splashColor: Colors.white,
                            onPressed: () {},
                            color: Color(0xFF4894e9),
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
                              'Office',
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 15.0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            transform:
                                Matrix4.translationValues(0.0, -15.0, 0.0),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(imagePath),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            color: Color(0xFF4894e9),
                            highlightColor: Color(0xFFFFFFFF),
                            textColor: Colors.white,
                            child: Icon(
                              Icons.mail_outline,
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
                              'Message',
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
                Container(
                  margin: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 5.0,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          name ?? "name not found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF6f6f6f),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          color: Colors.transparent,
                          splashColor: Colors.black26,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage(specialty)),
                            );
                          },
                          child: Text(
                            specialty ?? "specialty not found",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF4894e9),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "$rank  ⭐ ⭐ ⭐ ⭐ ⭐" ?? "rank not found",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF6f6f6f),
                    ),
                  ),
                ),
                sectionTitle("Biography"),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      biography ?? "",
                      style: TextStyle(
                        color: Color(0xFF9f9f9f),
                      ),
                    ),
                  ),
                ),
                sectionTitle("Physician History"),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MEDICAL EDUCATION',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                              Text(
                                medicalEducation ?? "",
                                style: TextStyle(
                                  color: Color(0xFF9f9f9f),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20.0,
                                ),
                              ),
                              Text(
                                'INTERNSHIP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                              Text(
                                internship ?? "",
                                style: TextStyle(
                                  color: Color(0xFF9f9f9f),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RESIDENCY',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                              Text(
                                residency ?? "",
                                style: TextStyle(
                                  color: Color(0xFF9f9f9f),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20.0,
                                ),
                              ),
                              Text(
                                'FELLOWSHIP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                              Text(
                                fellowship ?? "",
                                style: TextStyle(
                                  color: Color(0xFF9f9f9f),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sectionTitle("Office Gallery"),
                Container(
                  height: 150,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      officePhotos(context, "https://i.imgur.com/gKdDh8p.jpg"),
                      officePhotos(context, "https://i.imgur.com/bJ6gU02.jpg"),
                      officePhotos(context, "https://i.imgur.com/ZJZIrIB.jpg"),
                      officePhotos(context, "https://i.imgur.com/pTAuS44.jpg"),
                      officePhotos(context, "https://i.imgur.com/eY1lW0A.jpg"),
                    ],
                  ),
                ),
                sectionTitle("Appointments"),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  height: 60,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      appointmentDays("Monday", "June 15th", context),
                      appointmentDays("Tuesday", "June 19th`", context),
                      appointmentDays("Wednesday", "July 24th", context),
                      appointmentDays("Thursday", "July 12th", context),
                      appointmentDays("Friday", "July 13th", context),
                      appointmentDays("Saturday", "August 7th", context),
                      appointmentDays("Sunday", "August 9th", context),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  height: 50,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      appointmentTimes("9:00 AM", context),
                      appointmentTimes("9:30 AM", context),
                      appointmentTimes("10:00 AM", context),
                      appointmentTimes("10:30 AM", context),
                      appointmentTimes("11:00 AM", context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        flexibleSpace: Container(
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
        ),
        // title: Text('Title'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
              doctorProfile(),
            ],
          ),
        ),
      ),
    );
  }
}

Material appointmentDays(
    String appointmentDay, String appointmentDate, context) {
  return Material(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(
        right: 1.0,
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: OutlineButton(
        color: Colors.transparent,
        splashColor: Color(0xFF4894e9),
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: 6,
        ),
        onPressed: () {},
        textColor: Color(0xFF4894e9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                appointmentDay,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                appointmentDate,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Material appointmentTimes(String appointmentDay, context) {
  return Material(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(
        right: 1.0,
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: OutlineButton(
        color: Colors.transparent,
        splashColor: Color(0xFF4894e9),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        onPressed: () {
          print('View All Doctors Clicked');
        },
        textColor: Color(0xFF4894e9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            appointmentDay,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

Material officePhotos(context, String officePhotoUrl) {
  return Material(
    color: Colors.white,
    child: Container(
      width: 150.0,
      margin: const EdgeInsets.only(
        left: 20.0,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(officePhotoUrl),
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.redAccent,
      ),
    ),
  );
}
