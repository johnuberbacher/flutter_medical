import 'package:flutter/material.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class MyHealthPage extends StatefulWidget {
  final String name;
  MyHealthPage(this.name);

  @override
  _MyHealthPageState createState() => _MyHealthPageState(name);
}

class _MyHealthPageState extends State<MyHealthPage> {
  String name;
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
                  print(name);
                  return userProfileCard(
                    name: userProfileSnapshot.docs[index].data()["name"],
                    imagePath:
                        userProfileSnapshot.docs[index].data()["imagePath"],
                    age: userProfileSnapshot.docs[index].data()["age"],
                    firstName:
                        userProfileSnapshot.docs[index].data()["firstName"],
                    lastName:
                        userProfileSnapshot.docs[index].data()["lastName"],
                    gender: userProfileSnapshot.docs[index].data()["gender"],
                    language:
                        userProfileSnapshot.docs[index].data()["language"],
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
    String gender,
    String firstName,
    String lastName,
    String language,
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
                                  ? AssetImage('assets/images/user.jpg')
                                  : NetworkImage(imagePath),
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
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hello " +
                                  titleCase(name) +
                                  ", you're looking healthy today" ??
                              "name not found",
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
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'First Name',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                titleCase(firstName) ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Last Name',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                titleCase(lastName) ?? "empty",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                titleCase(gender) ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Age',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                age ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Language',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                age ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Height',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "$heightFeet' $heightInch\"" ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Weight',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "$weight lbs" ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                email ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 30,
                    right: 30,
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 30.0,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 15.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Coverages',
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
                    right: 20.0,
                    bottom: 15.0,
                  ),
                  child: Divider(
                    color: Colors.black12,
                    height: 1,
                    thickness: 1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 5.0,
                    bottom: 20.0,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
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
                                    BorderRadius.all(Radius.circular(30)),
                                color: Color(0xFFe9f0f3),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  size: 35,
                                ),
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
                                    BorderRadius.all(Radius.circular(30)),
                                color: Color(0xFFe9f0f3),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.hearing,
                                  size: 35,
                                ),
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
                                    BorderRadius.all(Radius.circular(30)),
                                color: Color(0xFFe9f0f3),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
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
      drawer: GlobalDrawer(),
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
