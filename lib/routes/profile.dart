import 'package:flutter/material.dart';

Material appointmentDays(
    String appointmentDay, String appointmentDate, context) {
  return Material(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(
        right: 1.0,
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: OutlineButton(
        color: Colors.transparent,
        splashColor: Color(0xFF4894e9),
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: 6,
        ),
        onPressed: () {
          print('View All Doctors Clicked');
        },
        textColor: Color(0xFF4894e9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                appointmentDay,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                appointmentDate,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Material appointmentTimes(String appointmentDay, context) {
  return Material(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(
        right: 1.0,
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: OutlineButton(
        color: Colors.transparent,
        splashColor: Color(0xFF4894e9),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        onPressed: () {
          print('View All Doctors Clicked');
        },
        textColor: Color(0xFF4894e9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            appointmentDay,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<bool> _selections = List.generate(3, (_) => false);
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
                              MaterialButton(
                                splashColor: Colors.white,
                                onPressed: () {},
                                color: Color(0xFF4894e9),
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.phone,
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(
                                  'Office',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF6f6f6f),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -15.0, 0.0),
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      AssetImage("assets/doctors/doctor-3.jpg"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                color: Color(0xFF4894e9),
                                highlightColor: Color(0xFFFFFFFF),
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.mail_outline,
                                  size: 30,
                                ),
                                padding: EdgeInsets.all(16),
                                shape: CircleBorder(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(
                                  'Message',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF6f6f6f),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                          bottom: 15.0,
                          top: 15.0,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Dr. Bruce Banner',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'General Surgery',
                                style: TextStyle(
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      child: Text(
                        '4.8 ⭐ ⭐ ⭐ ⭐ ⭐',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF6f6f6f),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30.0,
                        left: 20.0,
                        right: 20.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'General Surgery',
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
                        right: 15.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pharetra convallis posuere morbi leo urna molestie. Odio aenean sed adipiscing diam donec adipiscing. Volutpat maecenas volutpat blandit aliquam etiam erat. Vel pretium lectus quam id. ',
                          style: TextStyle(
                            color: Color(0xFF9f9f9f),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15.0,
                        left: 20.0,
                        right: 20.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Physician History',
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
                        top: 5.0,
                        left: 20.0,
                        right: 20.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MEDICAL EDUCATION',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF6f6f6f),
                                    ),
                                  ),
                                  Text(
                                    'Lorem ipsum dolor ',
                                    style: TextStyle(
                                      color: Color(0xFF9f9f9f),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                  ),
                                  Text(
                                    'INTERNSHIP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF6f6f6f),
                                    ),
                                  ),
                                  Text(
                                    'Lorem ipsum dolor ',
                                    style: TextStyle(
                                      color: Color(0xFF9f9f9f),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RESIDENCY',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF6f6f6f),
                                    ),
                                  ),
                                  Text(
                                    'Lorem ipsum dolor ',
                                    style: TextStyle(
                                      color: Color(0xFF9f9f9f),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                  ),
                                  Text(
                                    'FELLOWSHIP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF6f6f6f),
                                    ),
                                  ),
                                  Text(
                                    'Lorem ipsum dolor ',
                                    style: TextStyle(
                                      color: Color(0xFF9f9f9f),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15.0,
                        left: 20.0,
                        right: 20.0,
                        bottom: 15.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Appointments',
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
                        bottom: 15.0,
                      ),
                      height: 60,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          appointmentDays("Monday", "June 15th", context),
                          appointmentDays("Tuesday", "June 19th`", context),
                          appointmentDays("Wednesday", "July 24th", context),
                          appointmentDays("Thursday", "July 12th", context),
                          appointmentDays("Friday", "July 13th", context),
                          appointmentDays("Saturday", "August 7th", context),
                          appointmentDays("Sunday", "August 9th", context),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 15.0,
                      ),
                      height: 50,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          appointmentTimes("9:00 AM", context),
                          appointmentTimes("9:30 AM", context),
                          appointmentTimes("10:00 AM", context),
                          appointmentTimes("10:30 AM", context),
                          appointmentTimes("11:00 AM", context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
