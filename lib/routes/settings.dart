import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(

        title: Text(
          "Settings",
          style: appBarText,
        ),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {
                  //Navigator.pushNamed(context, "/account");
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.dark_mode,

                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("Theme")
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
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("Language")),
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
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.people,
                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("Credits")),
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
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("Logout")),
                    Icon(
                      Icons.chevron_right,
                      size: 33,
                    ),

                  ],
                )),
          ),



        ],
      ),
      //bottomNavigationBar: Bottom(),
    );
  }
}
