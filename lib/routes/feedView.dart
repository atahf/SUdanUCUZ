import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../services/db.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            auth.signOut();
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'FEED VIEW',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.lightBlue,
              ),
            ),

          ),


          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/profile");

            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text("Profile"),
            ),

          ),

        ],
      ),
    );
  }
}
