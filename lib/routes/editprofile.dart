import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "../routes/account.dart";

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  User1 user = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 30),
            Icon(
              Icons.edit,
              size: 25,
            ),
            SizedBox(width: 14),
            Text("Edit Profile",
                style: TextStyle(fontSize: 25)),
          ],
        ),
        centerTitle: true,
        leading: BackButton(),

        backgroundColor: Colors.grey[800],
        elevation: 0,

      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 30),
          Center(
            child: Stack(
              children: [
                ClipOval(

                  child: Image.asset("assets/eminem.jpg", fit: BoxFit.cover,
                    width:128, height: 128,),
                ),
                Positioned(
                  bottom: 1,
                  right: 4,
                  child: ClipOval(
                    child: Container(
                      width: 35,
                      height:35,
                      color: Colors.white,
                      padding: EdgeInsets.all(2),
                      child: ClipOval(
                        child: Container(
                          width: 20,
                          height:20,

                          color: Colors.red,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: (){
                              //xxx
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size:20,
                            ),),



                        ),
                      ),
                    ),
                  ),
                ),

              ],

            ),

          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text("Name",
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold, color: Colors.white),)
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: user.name, floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),

                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text("Email",
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold, color: Colors.white),)
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: user.email, floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),

                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text("About",
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold, color: Colors.white),)
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: user.about, floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),


                ),
              ],


            ),
          ),


        ],
      ),

    );
  }
}
