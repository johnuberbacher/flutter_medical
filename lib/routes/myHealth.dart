import 'package:flutter/material.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_medical/models/userProfile.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

DocumentSnapshot snapshot;

class MyHealthPage extends StatefulWidget {
  final String email;
  MyHealthPage(this.email);

  @override
  _MyHealthPageState createState() => _MyHealthPageState(email);
}

class _MyHealthPageState extends State<MyHealthPage> {
  String email;
  DateTime selectedDate = DateTime.now();
  _MyHealthPageState(this.email);
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot userProfileSnapshot;

  getProfile(email) async {
    print(email);
    databaseMethods.getUserProfile(email).then((val) {
      print(val.toString());
      setState(() {
        userProfileSnapshot = val;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    UserProfile.userHealthScore = 0;
    getProfile(email);

    Future.delayed(Duration(milliseconds: 250), () {
      print('here');
      setState(() {
        UserProfile.userHealthScore =
            userProfileSnapshot.docs[0].data()["userHealthScore"].toDouble();
      });
    });
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
                    userHealthScore: (userProfileSnapshot.docs[index]
                            .data()["userHealthScore"])
                        .toDouble(),
                    heightFeet:
                        userProfileSnapshot.docs[index].data()["heightFeet"],
                    heightInch:
                        userProfileSnapshot.docs[index].data()["heightInch"],
                    weight: userProfileSnapshot.docs[index].data()["weight"],
                    email: userProfileSnapshot.docs[index].data()["email"],
                    address: userProfileSnapshot.docs[index].data()["address"],
                    phone: userProfileSnapshot.docs[index].data()["phone"],
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
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark,
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
    double userHealthScore,
    String bmi,
    String heightFeet,
    String heightInch,
    String weight,
    String email,
    String address,
    String phone,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColorDark,
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
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: imagePath,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/images/user.jpg'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sectionTitle(context, "My Health"),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 20.0,
                        ),
                        padding: const EdgeInsets.all(
                          15.0,
                        ),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color(0xFFe9f0f3),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 17.5,
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                children: [
                                  myHealthScore(
                                      UserProfile.userHealthScore, context),
                                  Text(
                                    "MY HEALTH SCORE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "Hey " +
                                        titleCase(UserProfile.userFirstName) +
                                        "" +
                                        ", you're looking healthy today!" ??
                                    "name not found",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                sectionTitle(context, "My Stats"),
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
                              color: Theme.of(context).primaryColor,
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
                                    age ?? "0",
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
                              color: Theme.of(context).primaryColor,
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
                                    bmi ?? "0",
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
                              color: Theme.of(context).primaryColor,
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
                                    heightFeet ?? "0",
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
                              color: Theme.of(context).primaryColor,
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
                                      text: weight ?? "0",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' lbs',
                                          style: TextStyle(
                                            fontSize: 11,
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
                sectionTitle(context, "My Coverages"),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 5.0,
                  ),
                  child: Wrap(children: <Widget>[
                    myHealthCoverages("Medical", Icons.favorite_border),
                    myHealthCoverages("Dental", Icons.tag_faces_rounded),
                    myHealthCoverages("Vision", Icons.remove_red_eye),
                  ]),
                ),
                sectionTitle(context, "Preferences"),
                myHealthTextField(
                    hintText: 'Language', initialValue: language ?? ""),
                myHealthTextField(hintText: 'Email', initialValue: email ?? ""),
                myHealthTextField(hintText: 'Phone', initialValue: phone ?? ""),
                myHealthTextField(
                    hintText: 'Address', initialValue: address ?? ""),
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
      appBar: StandardAppBar(),
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
