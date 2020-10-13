import 'package:flutter/material.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/routes/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class CategoryPage extends StatefulWidget {
  final String name;
  CategoryPage(this.name);

  @override
  _CategoryPageState createState() => _CategoryPageState(name);
}

class _CategoryPageState extends State<CategoryPage> {
  String name;
  _CategoryPageState(this.name);
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot specialtyInfoSnapshot;

  getSpecialtyInfo(specialtyName) async {
    print(specialtyName);
    databaseMethods.getSpecialty(name).then((val) {
      print(val.toString());
      setState(() {
        specialtyInfoSnapshot = val;
        print(specialtyInfoSnapshot);
      });
    });
  }

  @override
  void initState() {
    getSpecialtyInfo(name);
  }

  Widget specialtyProfile() {
    return specialtyInfoSnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: specialtyInfoSnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return specialty(
                    specialtyName: specialtyInfoSnapshot.docs[index]
                        .data()["specialtyName"],
                    specialtyDescription: specialtyInfoSnapshot.docs[index]
                        .data()["specialtyDescription"],
                    specialtyImagePath: specialtyInfoSnapshot.docs[index]
                        .data()["specialtyImagePath"],
                    specialtyDoctorCount: specialtyInfoSnapshot.docs[index]
                        .data()["specialtyDoctorCount"],
                  );
                }),
          )
        : Container(
            child: Text("error"),
          );
  }

  Widget specialty({
    String specialtyName,
    String specialtyImagePath,
    String specialtyDescription,
    String specialtyDoctorCount,
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
            Text(
              specialtyName ?? "name not found",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black12,
              ),
            ),
          ],
        ));
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
              specialtyProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
