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

  getAllSpecialties() async {
    return FirebaseFirestore.instance
        .collection("specialties")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getDoctorProfile(String name) async {
    print(name);
    return FirebaseFirestore.instance
        .collection("doctors")
        .where("name", isEqualTo: name)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }
}
