import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
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
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -15.0, 0.0),
                                child: Material(
                                  elevation: 0.0,
                                  clipBehavior: Clip.hardEdge,
                                  color: Colors.transparent,
                                  child: Ink.image(
                                    image: AssetImage(
                                        'assets/images/category-banner.jpg'),
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height: 200.0,
                                    child: InkWell(
                                      onTap: () {},
                                    ),
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
                        right: 20.0,
                        left: 20.0,
                        bottom: 15.0,
                        top: 15.0,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Cardiology',
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
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pharetra convallis posuere morbi leo urna molestie. Odio aenean sed adipiscing diam donec adipiscing. Volutpat maecenas volutpat blandit aliquam etiam erat. Vel pretium lectus quam id. In ante metus dictum at tempor commodo ullamcorper. Sed faucibus turpis in eu mi bibendum neque.',
                          style: TextStyle(
                            color: Color(0xFF9f9f9f),
                          ),
                        ),
                      ),
                    ),
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
