import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/services/DatabaseService.dart';
import '../services/auth.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "../routes/account.dart";

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key,required this.name,required this.mail,required this.pp,required this.about}) : super(key: key);

  final String name;
  final String about;
  final String mail;
  final String pp;


  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  TextEditingController itemController = TextEditingController();
  TextEditingController itemController2 = TextEditingController();
  TextEditingController itemController3 = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  File? pp;
  String ProfilePicture = "";

  bool isEmpty(String s){
    if (s.length == 0){
      return true;
    }
    return false;
  }

  List<String> splitName(String s){
    return s.split(" ");
  }

  Future<void> uploadPp() async{
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pp = File(image!.path);
    });
    var ref = FirebaseStorage.instance.ref().child("pp").child(currentUser!.uid);
    var uploadTask = ref.putFile(pp!);
    var url = await uploadTask;
    var res = await url.ref.getDownloadURL();
    setState(() {
      ProfilePicture = res;
    });


  }



  Future<void> setPp() async {

    if (ProfilePicture != ""){
      await FirebaseFirestore.instance.collection("UserProfile").doc(currentUser!.uid).update({"pp":ProfilePicture});
    }

  }



  Future updateUserData(String name,String mail,String lname,String about) async {
    return await FirebaseFirestore.instance.collection("UserProfile").doc(currentUser!.uid).update({
      "mail": mail,
      "lname": lname,
      "name": name,
      "about":about,

    });
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
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.pp),
                  radius: 64
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
                              uploadPp();
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
                  controller: itemController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: widget.name ,
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
                  controller: itemController2,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: widget.mail,
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
                  controller: itemController3,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,

                    hintText: widget.about,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),


                ),
                SizedBox(height: 20,),
                OutlinedButton(
                  onPressed: (){
                    List<String> sl = splitName(itemController.text);


                    updateUserData(sl[0], itemController2.text,sl[1],itemController3.text );
                    setPp();
                    Navigator.pop(context);
                  },
                  child: Text("Submit"),
                  style: mainBstyle,
                ),
              ],


            ),
          ),


        ],
      ),

    );
  }
}
