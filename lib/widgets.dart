import 'package:flutter/material.dart';
import 'package:flutter_medical/main.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/routes/search.dart';
import 'package:flutter_medical/routes/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class GlobalAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
      ],
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class GlobalDrawer extends StatefulWidget {
  @override
  _GlobalDrawerState createState() => _GlobalDrawerState();
}

class _GlobalDrawerState extends State<GlobalDrawer> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorSnapshot;
  QuerySnapshot specialtySnapshot;

  @override
  void initState() {
    getSpecialties();
  }

  getSpecialties() async {
    databaseMethods.getAllSpecialties().then((val) {
      print(val.toString());
      setState(() {
        specialtySnapshot = val;
        print(specialtySnapshot);
      });
    });
  }

  Widget specialtyList() {
    return specialtySnapshot != null
        ? MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: ListView.builder(
                itemCount: specialtySnapshot.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return specialtyDrawerItem(
                    specialtyName:
                        specialtySnapshot.docs[index].data()["specialtyName"],
                    specialtyDoctorCount: specialtySnapshot.docs[index]
                        .data()["specialtyDoctorCount"],
                    specialtyImagePath: specialtySnapshot.docs[index]
                        .data()["specialtyImagePath"],
                  );
                },
              ),
            ),
          )
        : Text("error");
  }

  Widget specialtyDrawerItem(
      {String specialtyName,
      String specialtyDoctorCount,
      String specialtyImagePath}) {
    return ListTile(
      leading: Image.network(
        specialtyImagePath,
        height: 25,
        width: 25,
      ),
      title: Text(specialtyName ?? "error"),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(specialtyName),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 170.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [const Color(0xFF6aa6f8), const Color(0xFF1a60be)],
              ),
            ),
            child: DrawerHeader(
              child: Row(
                children: [
                  new Container(
                    margin: EdgeInsets.only(
                      right: 15.0,
                    ),
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            new NetworkImage("https://i.imgur.com/iQkzaTO.jpg"),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            'Welcome back, John!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            'How can we help you today?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xAAFFFFFFF),
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
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Top Doctors'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('All Doctors'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.mood),
            title: Text("Browse by Specialty"),
            children: <Widget>[
              specialtyList(),
            ],
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Doctor Lookup'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Resources'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
