import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_medical/main.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/routes/myHealth.dart';
import 'package:flutter_medical/routes/search.dart';
import 'package:flutter_medical/routes/category.dart';
import 'package:flutter_medical/models/constant.dart';
import 'package:flutter_medical/services/authenticate.dart';
import 'package:flutter_medical/services/authentication.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

class UserProfileAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
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
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorSnapshot;
  QuerySnapshot specialtySnapshot;

  @override
  void initState() {
    getSpecialties();
  }

  getSpecialties() async {
    databaseMethods.getAllSpecialties().then((val) {
      setState(() {
        specialtySnapshot = val;
      });
    });
  }

  Widget specialtyList() {
    return specialtySnapshot != null
        ? MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(specialtyName ?? "not_found"),
          Container(
            width: 35,
            height: 35,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0x156aa6f8)),
            child: Align(
              alignment: Alignment.center,
              child: Text(specialtyDoctorCount ?? "0"),
            ),
          ),
        ],
      ),
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
                        image: new CachedNetworkImageProvider(
                            "https://i.imgur.com/iQkzaTO.jpg"),
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
                            'Welcome back, ' + titleCase(Constants.myName),
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
            leading: Icon(Icons.favorite_border),
            title: Text('My Health'),
            onTap: () {
              Navigator.push(
                context,
                SlideRightRoute(page: MyHealthPage(Constants.myName)),
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
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.icon,
      this.hint,
      this.obsecure = false,
      this.validator,
      this.onSaved});
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: true,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: Theme.of(context).primaryColor),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

String titleCase(String text) {
  if (text.length <= 1) return text.toUpperCase();
  var words = text.split(' ');
  var capitalized = words.map((word) {
    var first = word.substring(0, 1).toUpperCase();
    var rest = word.substring(1);
    return '$first$rest';
  });
  return capitalized.join(' ');
}

Widget MyHealthTextField({String hintText, String initialValue}) {
  // new
  return Container(
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
    ),
    child: TextFormField(
      textAlign: TextAlign.end,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        prefix: Padding(
          padding: EdgeInsets.only(
            right: 15,
          ),
          child: Text(hintText),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    ),
  );
}

Widget myHealthCoverages(String coverageName) {
  return FractionallySizedBox(
    widthFactor: 0.33,
    child: AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.only(
          right: 15.0,
          bottom: 15.0,
        ),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xFFe9f0f3),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 35,
              ),
              Text(
                coverageName,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget sectionTitle(String title) {
  return Container(
    margin: const EdgeInsets.only(
      top: 20.0,
      left: 20.0,
      right: 20.0,
      bottom: 20.0,
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF4894e9),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Divider(
            color: Colors.black12,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    ),
  );
}
