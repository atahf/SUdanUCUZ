import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/CommentView.dart';
import 'package:project/models/myCommentsList.dart';
import 'package:project/models/myItemList.dart';
import 'package:project/models/searchView.dart';
import 'package:project/routes/addListing.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../services/db.dart';
import "../routes/bottom.dart";
import 'package:project/models/ItemList.dart';
import 'package:project/models/notifications.dart';

class MyComments extends StatefulWidget {

  MyComments({Key? key}) : super(key: key);



  @override
  State<MyComments> createState() => _MyCommentsState();
}

class _MyCommentsState extends State<MyComments> {
  AuthService auth = AuthService();

  TextEditingController control = TextEditingController();




  @override
  Widget build(BuildContext context) {





    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],

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





                  ],
                ),
              ),

              SizedBox(height: 20),

              MyCommentView(),





            ],



          ),
        ),
      ),
      bottomNavigationBar: Bottom(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddListing()));
        },
        child: Icon(Icons.add),
      ),

    );
  }
}