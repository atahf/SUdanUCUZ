import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "bottom.dart";

class User1{
  final String imagePath;
  final String name;
  final String email;
  final String about;

  const User1({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
});
}

class UserPreferences{
  static const myUser = User1(
    imagePath: "assets/logo.png",
    name: "Harun Akçay",
    email: "meteharun@sabanciuniv.edu",
    about: "Sophomore / Computer Engineer\nYou can contact me if you want high grades in math exams :)",
  );
}

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 30),
            Icon(
              Icons.account_circle_outlined,
              size: 33,
            ),
            SizedBox(width: 14),
            Text("My Account",
            style: TextStyle(fontSize: 25)),
          ],
        ),
        centerTitle: true,
        leading: BackButton(),

        backgroundColor: Colors.grey[800],
        elevation: 0,
        actions: [

          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, "/editprofile");
              },
              icon: Icon(
                Icons.edit
              ),),
        ],
      ),
      body: ListView(

        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 30),
          Center(
            child: ClipOval(

              child: Image.asset("assets/eminem.jpg", fit: BoxFit.cover,
              width:128, height: 128,),
            ),
          ),
          SizedBox(height: 30),
          buildName(user),
          SizedBox(height: 30),
          //Center(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "4.9",
                        style: TextStyle(color: Colors.amberAccent[200],
                            fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height:5),

                      Text(
                        "Rating",
                        style: TextStyle(fontSize: 15,color: Colors.grey[400],fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),

                MaterialButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "13",
                        style: TextStyle(color: Colors.amberAccent[200],
                            fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height:5),
                      Text(
                        "Sales",
                        style: TextStyle(fontSize: 15,color: Colors.grey[400],fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                MaterialButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "25",
                        style: TextStyle(color: Colors.amberAccent[200],
                            fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height:5),
                      Text(
                        "Purchases",
                        style: TextStyle(fontSize: 15,color: Colors.grey[400],fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About",
                  style: TextStyle(fontSize: 25,color: Colors.grey[400],
                      fontWeight: FontWeight.bold)
                ),
                SizedBox(height:17),
                Text(
                  user.about,
                    style: TextStyle(fontSize: 15,color: Colors.white,
                        fontWeight: FontWeight.bold)
                ),

              ],
            ),
          ),



        ],

      ),
      bottomNavigationBar: Bottom(),
    );
  }
}

Widget buildName(User1 user) => Column(
  children: [
    Text(
      user.name,
      style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
    ),
    const SizedBox(height: 9),
    Row(
      children: [
        SizedBox(width: 90),
        Icon(
          Icons.email,
          color: Colors.grey[400],
        ),
        SizedBox(width: 14),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey[400]),
        ),
      ],
    ),
  ],
);
