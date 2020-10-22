import 'package:flutter/material.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

DocumentSnapshot snapshot;

class MyHealthPage extends StatefulWidget {
  final String name;
  MyHealthPage(this.name);

  @override
  _MyHealthPageState createState() => _MyHealthPageState(name);
}

class _MyHealthPageState extends State<MyHealthPage> {
  String name;
  DateTime selectedDate = DateTime.now();
  _MyHealthPageState(this.name);
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot userProfileSnapshot;

  getProfile(name) async {
    print(name);
    databaseMethods.getUserProfile(name).then((val) {
      print(val.toString());
      setState(() {
        userProfileSnapshot = val;
      });
    });
  }

  @override
  void initState() {
    getProfile(name);
  }

  Widget loadUserProfile() {
    return userProfileSnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: userProfileSnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return userProfileCard(
                    name: userProfileSnapshot.docs[index].data()["name"],
                    imagePath:
                        userProfileSnapshot.docs[index].data()["imagePath"],
                    age: userProfileSnapshot.docs[index].data()["age"],
                    dob: userProfileSnapshot.docs[index].data()["dob"],
                    firstName:
                        userProfileSnapshot.docs[index].data()["firstName"],
                    lastName:
                        userProfileSnapshot.docs[index].data()["lastName"],
                    gender: userProfileSnapshot.docs[index].data()["gender"],
                    language:
                        userProfileSnapshot.docs[index].data()["language"],
                    bmi: userProfileSnapshot.docs[index].data()["bmi"],
                    heightFeet:
                        userProfileSnapshot.docs[index].data()["heightFeet"],
                    heightInch:
                        userProfileSnapshot.docs[index].data()["heightInch"],
                    weight: userProfileSnapshot.docs[index].data()["weight"],
                    email: userProfileSnapshot.docs[index].data()["email"],
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

  Widget userProfileCard({
    String name,
    String imagePath,
    String age,
    String dob,
    String gender,
    String firstName,
    String lastName,
    String language,
    String bmi,
    String heightFeet,
    String heightInch,
    String weight,
    String email,
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
                              backgroundImage: (imagePath == null)
                                  ? CachedNetworkImageProvider(
                                      'assets/images/user.jpg',
                                    )
                                  : CachedNetworkImageProvider(imagePath),
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
                    left: 40.0,
                    right: 40.0,
                    bottom: 30.0,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Hey " +
                                  titleCase(name) +
                                  ", you're looking healthy today" ??
                              "name not found",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
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
                    right: 5.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 15.0,
                              bottom: 15.0,
                            ),
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF4894e9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    age ?? "",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Age",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 15.0,
                              bottom: 15.0,
                            ),
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF4894e9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    bmi ?? "",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                                Text(
                                  "BMI",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 15.0,
                              bottom: 15.0,
                            ),
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF4894e9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    "$heightFeet' $heightInch\"" ?? "",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Height",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 15.0,
                              bottom: 15.0,
                            ),
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFF4894e9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: weight ?? "",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'lbs',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sectionTitle("My Profile"),
                MyHealthTextField(hintText: 'Language', initialValue: language),
                MyHealthTextField(hintText: 'Email', initialValue: email),
                sectionTitle("My Coverages"),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 5.0,
                    bottom: 20.0,
                  ),
                  child: Wrap(children: <Widget>[
                    myHealthCoverages("Medical"),
                    myHealthCoverages("Dental"),
                    myHealthCoverages("Vision"),
                    myHealthCoverages("Life"),
                  ]),
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
      extendBodyBehindAppBar: true,
      appBar: UserProfileAppBar(),
      body: SingleChildScrollView(
        child: loadUserProfile(),
      ),
    );
  }
}

class UserProfileDetailItem extends StatelessWidget {
  String name;
  @override
  Widget build(BuildContext context) {
    return Text("testing! $name");
  }
}
