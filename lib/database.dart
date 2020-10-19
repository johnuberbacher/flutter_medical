import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getAllDoctors() async {
    return FirebaseFirestore.instance
        .collection("doctors")
        .orderBy("rank")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getAllDoctorsPagination(documentLimit) async {
    return await FirebaseFirestore.instance
        .collection("doctors")
        .orderBy("rank")
        .limit(documentLimit)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getAllDoctorsPaginationStartAfter(documentLimit, lastDocument) async {
    return await FirebaseFirestore.instance
        .collection("doctors")
        .orderBy("rank")
        .startAfterDocument(lastDocument)
        .limit(documentLimit)
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

  getDoctorBySpecialty(String specialty) async {
    return await FirebaseFirestore.instance
        .collection("doctors")
        .where("specialty", isEqualTo: specialty)
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

  getSpecialty(String specialty) async {
    return FirebaseFirestore.instance
        .collection("specialties")
        .where("specialty", isEqualTo: specialty)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getDoctorProfile(String name) async {
    return FirebaseFirestore.instance
        .collection("doctors")
        .where("name", isEqualTo: name)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserProfile(String name) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: name)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }
}
