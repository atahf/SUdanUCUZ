import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../services/db.dart';
import "../routes/bottom.dart";
class FeedView extends StatefulWidget {

   FeedView({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  AuthService auth = AuthService();

  DBService db = DBService();

  @override
  Widget build(BuildContext context) {

    db.addUser('name', 'surname', 'mail', 'token');
    db.addUserAutoID('nameAuto', 'surnameAuto', 'mail@auto', 'token');

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
              icon: Icon(
                  Icons.settings
              ),
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
                        onChanged: (value) {
                          //search
                        },
                        decoration:  InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search, color: Colors.grey[800]),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 9,
                          ),
                        ),
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
                                //notifications
                              },
                              icon: Icon(
                                  Icons.notifications,
                              ),
                              iconSize: 30,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          Positioned(
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
                                  "3", style: TextStyle(fontSize: 12,
                                height: 1, color: Colors.white, fontWeight: FontWeight.w600)
                                ),
                              ),
                            ),
                          ),

                        ],
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
                          //notifications
                        },
                        icon: Icon(
                          Icons.add_circle,
                        ),
                        iconSize: 30,
                        padding: EdgeInsets.zero,
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal:20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal:20,vertical:15),
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "30% Discount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[800],
                    ),
                  ),
              ),

            ],


          ),
        ),
      ),
      bottomNavigationBar: Bottom(),


    );
  }
}
