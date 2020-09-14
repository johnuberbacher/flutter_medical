import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/routes/profile.dart';

DocumentSnapshot snapshot;

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();
  QuerySnapshot searchSnapshot;

  List<bool> isSelected = [false, false, false];

  getSearch() async {
    databaseMethods
        .getDoctorBySearch(searchTextEditingController.text)
        .then((val) {
      print(val.toString());
      print(searchTextEditingController.text.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget doctorCard({String name, String specialty, String imagePath}) {
    return Material(
      color: const Color(0xFFFFFFFF),
      child: Container(
        margin: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 10.0,
        ),
        child: Card(
          elevation: 3.0,
          child: new InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(name)),
              );
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
                                  '⭐  ' + "placeholder",
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

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return doctorCard(
                name: searchSnapshot.docs[index].data()["name"],
                specialty: searchSnapshot.docs[index].data()["specialty"],
                imagePath: searchSnapshot.docs[index].data()["imagePath"],
              );
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Doctor Lookup"),
          // centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [const Color(0xFF6aa6f8), const Color(0xFF1a60be)],
              ),
            ),
          ),
          // title: Text('Title'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
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
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15.0,
                      left: 20.0,
                      right: 20.0,
                      bottom: 20.0,
                    ),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.none,
                      controller: searchTextEditingController,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        return val.isEmpty || val.length < 4
                            ? "Please enter username"
                            : null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: 20.0,
                            left: 20.0,
                            bottom: 1.0,
                          ),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF6aa6f8),
                          ),
                        ),
                        // hintText: hintText,
                        hintStyle: TextStyle(
                          color: Color(0xFFb1b2c4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      onChanged: (text) {
                        getSearch();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 7.5,
                      ),
                      child: OutlineButton(
                        color: Colors.transparent,
                        splashColor: Color(0xFF4894e9),
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          print('Sort by Name Clicked');
                        },
                        textColor: Color(0xFF4894e9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 3.75,
                        left: 3.75,
                      ),
                      child: OutlineButton(
                        color: Colors.transparent,
                        splashColor: Color(0xFF4894e9),
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          print('Sort by Specialty Clicked');
                        },
                        textColor: Color(0xFF4894e9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Specialty',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 7.5,
                      ),
                      child: OutlineButton(
                        color: Colors.transparent,
                        splashColor: Color(0xFF4894e9),
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          print('Sort by Rank Clicked');
                        },
                        textColor: Color(0xFF4894e9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Rank',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        )));
  }
}
