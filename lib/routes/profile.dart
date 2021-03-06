import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/models/PreviousOrdersList.dart';
import 'package:project/models/myCommentsList.dart';
import 'package:project/routes/MyComments.dart';
import 'package:project/routes/PreviousOrders.dart';
import 'package:project/routes/addListing.dart';
import 'package:project/routes/bottom.dart';
import '../services/auth.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/routes/settings.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}



class _ProfileState extends State<Profile> {

  String pp = "";
  var currentUser = FirebaseAuth.instance.currentUser;

  Future getPp () async{
    var doc = await FirebaseFirestore.instance.collection("UserProfile").doc(currentUser!.uid).get();

    setState(() {
      pp = doc["pp"];
    });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          "My Profile",
          style: appBarText,
        ),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,

                ),
                onPressed: () {},
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/settings");
                  },
                  icon: Icon(
                    Icons.settings
                  ),
                ),
              )
          ),

        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),

          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(pp),
                ),
                SizedBox(
                  height: 46,
                  width: 46,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(""),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: FlatButton(
              padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {
                  Navigator.pushNamed(context, "/account");
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,

                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("My account")
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 33,
                    ),

                  ],
                )),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {
                  Navigator.pushNamed(context, "/myproducts");
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.work_rounded,
                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("My products")),
                    Icon(
                      Icons.chevron_right,
                      size: 33,
                    ),

                  ],
                )),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyComments()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.comment_sharp,
                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("My comments")),
                    Icon(
                      Icons.chevron_right,
                      size: 33,
                    ),

                  ],
                )),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PreviousOrders()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("Previous orders / sales")),
                    Icon(
                      Icons.chevron_right,
                      size: 33,
                    ),

                  ],
                )),
          ),



        ],
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}


