import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/Search2.dart';
import 'package:project/models/categoryModel.dart';
import 'package:project/models/searchView.dart';
import 'package:project/routes/addListing.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../services/db.dart';
import "../routes/bottom.dart";
import 'package:project/models/ItemList.dart';
import 'package:project/models/notifications.dart';

class FeedView extends StatefulWidget {
  FeedView({Key? key, required this.analytics, required this.observer})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  AuthService auth = AuthService();

  TextEditingController control = TextEditingController();
  DBService db = DBService();
  int notifNumber = 0;
  Notifications notifs = Notifications();
  String category = "all";
  List<String> colors = [
    "orange",
    "blue",
    "blue",
    "blue",
    "blue",
    "blue",
    "blue"
  ];

  @override
  void setState(VoidCallback fn) {
    notifNumber = notifs.getNotificationsCount();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: IconButton(
          onPressed: () {
            auth.signOut();
          },
          icon: Icon(Icons.logout),
        ),
        title: Row(
          children: [
            SizedBox(width: 20),
            Container(
              child: Image.asset("assets/su.png", fit: BoxFit.cover),
            ),
            SizedBox(width: 50),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 270,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: control,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Search",
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[800]),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 9,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      //padding: EdgeInsets.all(12),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        color: Colors.amberAccent[400],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchView2(query: control)),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                        ),
                        iconSize: 30,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(50),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Container(
                            //padding: EdgeInsets.all(12),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              color: Colors.amberAccent[400],
                              onPressed: () {
                                Navigator.pushNamed(context, "/notifications");
                              },
                              icon: Icon(
                                Icons.notifications,
                              ),
                              iconSize: 30,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          /*Positioned(
                            right: 5,
                            top: 5,
                            child: Container(height:16,width: 16,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(width:1.5,color: Colors.white),

                            ),
                              child: Center(
                                child: Text(
                                    notifNumber.toString() , style: TextStyle(fontSize: 12,
                                height: 1, color: Colors.white, fontWeight: FontWeight.w600)
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    InkWell(
                      child: Cmodel(cname: 'All', color: colors[0]),
                      onTap: () {
                        setState(() {
                          category = "all";
                          colors[colors.indexOf("orange")] = "blue";
                          colors[0] = "orange";
                        });
                      },
                    ),
                    InkWell(
                      child: Cmodel(cname: 'Electronics', color: colors[1]),
                      onTap: () {
                        setState(() {
                          category = "Electronics";
                          colors[colors.indexOf("orange")] = "blue";
                          colors[1] = "orange";
                        });
                      },
                    ),
                    InkWell(
                      child: Cmodel(cname: 'Fashion', color: colors[2]),
                      onTap: () {
                        setState(() {
                          category = "Fashion";
                          colors[colors.indexOf("orange")] = "blue";
                          colors[2] = "orange";
                        });
                      },
                    ),
                    InkWell(
                      child: Cmodel(cname: 'Outdoor', color: colors[3]),
                      onTap: () {
                        setState(() {
                          category = "Outdoor";
                          colors[colors.indexOf("orange")] = "blue";
                          colors[3] = "orange";
                        });
                      },
                    ),
                    InkWell(
                      child: Cmodel(cname: 'Art', color: colors[4]),
                      onTap: () {
                        setState(() {
                          category = "Art";
                          colors[colors.indexOf("orange")] = "blue";
                          colors[4] = "orange";
                        });
                      },
                    ),
                    InkWell(
                      child: Cmodel(cname: 'Craft', color: colors[5]),
                      onTap: () {
                        setState(() {
                          category = "Craft";
                          colors[colors.indexOf("orange")] = "blue";
                          colors[5] = "orange";
                        });
                      },
                    ),
                    InkWell(
                      child: Cmodel(cname: 'Book', color: colors[6]),
                      onTap: () {
                        setState(() {
                          category = "Book";
                          colors[colors.indexOf("orange")] = "blue";
                          colors[6] = "orange";
                        });
                      },
                    ),
                  ],
                ),
              ),
              ItemList(
                category: category,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddListing()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
