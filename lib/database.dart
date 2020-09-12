import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  getAllDoctors() async {
    return FirebaseFirestore.instance
        .collection("doctors")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getAllSpecialties() async {
    return FirebaseFirestore.instance
        .collection("specialties")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getDoctorBySearch(String searchString) async {
    return await FirebaseFirestore.instance
        .collection("doctors")
        .where("name", isGreaterThanOrEqualTo: searchString)
        .where("name", isLessThanOrEqualTo: searchString + "z")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getDoctorProfile(String name) async {
    return await FirebaseFirestore.instance
        .collection("doctors")
        .where("users", arrayContains: name)
        .snapshots();
  }
}
