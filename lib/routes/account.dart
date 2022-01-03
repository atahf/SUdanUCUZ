import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/routes/editprofile.dart';
import '../services/auth.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "bottom.dart";
import "signup.dart";
import "package:project/services/db.dart";



class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String name = "";
  String mail = "";
  String about = "";
  String pp = "";


  var currentUser = FirebaseAuth.instance.currentUser;

  Future<void> setUserName() async{
    var document = await FirebaseFirestore.instance.collection("UserProfile").doc(currentUser!.uid).get();


    setState(() {
      name = document.get("name")+" " + document.get("lname");
      mail = document.get("mail");
      about = document.get("about");
      pp = document.get("pp");

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserName();
  }

  @override
  Widget build(BuildContext context) {









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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Editprofile(name:name, mail: mail, pp: pp, about: about)),
              );

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
            child: CircleAvatar(
                backgroundImage: NetworkImage(pp),
                radius: 64
            ),
          ),
          SizedBox(height: 30),
      Column(
        children: [
          Text(
            name,
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
                mail,
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
        ],
      ),
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
                  about,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),

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

