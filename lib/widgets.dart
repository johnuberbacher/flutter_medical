import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_medical/main.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/routes/myHealth.dart';
import 'package:flutter_medical/routes/search.dart';
import 'package:flutter_medical/routes/category.dart';
import 'package:flutter_medical/routes/profile.dart';
import 'package:flutter_medical/routes/createProfile.dart';
import 'package:flutter_medical/models/userProfile.dart';
import 'package:flutter_medical/services/authenticate.dart';
import 'package:flutter_medical/services/authentication.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

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
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class StandardAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
      ),
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

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
  void initState() {
    getSpecialties();
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
                colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark,
                ],
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
                    ),
                    child: ClipOval(
                      child: UserProfile.userImagePath != null
                          ? CachedNetworkImage(
                              imageUrl: UserProfile.userImagePath,
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
                            )
                          : (Container()),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: UserProfile.userFirstName != null
                              ? Text(
                                  'Welcome back, ' + UserProfile.userFirstName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                )
                              : Text(
                                  'Welcome back, null',
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
                MaterialPageRoute(
                    builder: (context) =>
                        MyHealthPage(UserProfile.userFirstName)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Top Doctors'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateProfilePage()),
              );
            },
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
            leading: Icon(Icons.web),
            title: Text('Visit my Website'),
            onTap: () => launchURL('https://johnuberbacher.com'),
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

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final num rating;
  final Color color;
  final MainAxisAlignment rowAlignment;

  StarRating({
    this.starCount = 5,
    this.rating = .0,
    this.color,
    this.rowAlignment = MainAxisAlignment.center,
  });

  Widget buildStar(
      BuildContext context, int rank, MainAxisAlignment rowAlignment) {
    Icon icon;
    if (rank >= rating) {
      return icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (rank > rating - 1 && rank < rating) {
      return icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      return icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: rowAlignment,
      children: new List.generate(
        starCount,
        (rank) => buildStar(context, rank, rowAlignment),
      ),
    );
  }
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

Widget myHealthTextField({String hintText, String initialValue}) {
  // new
  return Container(
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      bottom: 20.0,
    ),
    child: TextFormField(
      textAlign: TextAlign.end,
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        hintText: hintText,
        prefix: Padding(
          padding: EdgeInsets.only(
            right: 15,
          ),
          child: Text(
            hintText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return '';
        }
        return null;
      },
    ),
  );
}

Widget imageDialog(context, imageUrl) {
  return Dialog(
    child: Container(
      width: MediaQuery.of(context).size.width * 1.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(imageUrl), fit: BoxFit.cover)),
    ),
  );
}

Widget customTextField(context, String hintText, IconData icon) {
  return TextField(
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color(0xFFb1b2c4),
      ),
      border: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(60),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(60),
      ),
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      contentPadding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 25.0,
      ),
      prefixIcon: Icon(
        icon,
        color: Color(0xFF6aa6f8),
      ),
      //
    ),
    style: TextStyle(color: Colors.white),
  );
}

Widget myHealthCoverages(String coverageName, IconData coverageIcon) {
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
                coverageIcon,
                size: 35,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 7.5,
                ),
                child: Text(
                  coverageName,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget myHealthScore(double userHealthScore, context) {
  return Container(
    child: Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xFFe9f0f3),
      ),
      child: Center(
        child: AnimatedFlipCounter(
          duration: Duration(milliseconds: 500),
          value: userHealthScore ?? 1,
          /* pass in a number like 2014 */
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    ),
  );
}

Widget sectionTitle(context, String title) {
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
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 20,
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

Widget doctorCard(
    {String firstName,
    String lastName,
    String prefix,
    String specialty,
    String imagePath,
    num rank,
    BuildContext context}) {
  return Container(
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      top: 10.0,
    ),
    child: Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      color: Colors.white,
      child: new InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfilePage(lastName),
            ),
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
                    child: ClipOval(
                      child: imagePath != null
                          ? CachedNetworkImage(
                              imageUrl: imagePath,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 70.0,
                                height: 72.5,
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
                            )
                          : (Container()),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            '${prefix.capitalize()} ${firstName.capitalize()} ${lastName.capitalize()}',
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
                            child: StarRating(
                              rating: rank,
                              rowAlignment: MainAxisAlignment.start,
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
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
