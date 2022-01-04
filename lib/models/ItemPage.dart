import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project/models/UserModel.dart';
import 'package:project/routes/Comments.dart';
import 'package:project/services/DatabaseService.dart';

import "../routes/bottom.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/design/TextStyles.dart';



class ItemPage extends StatefulWidget {
  const ItemPage({Key? key, required this.iid}) : super(key: key);

  final String iid;




  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

  var currentUser = FirebaseAuth.instance.currentUser!.uid;

  String? image = "";
  String? description = "";
  String? price = "";
  String? category = "";
  String? seller = "";
  double rating = 0;
  int votes = 0;
  String seller_id = "";

  Future<void> setData() async{
    var document = await FirebaseFirestore.instance.collection("Items").doc(widget.iid).get();
    var sName = await FirebaseFirestore.instance.collection("UserProfile").doc(document["uid"]).get();
    var ratingGet = await FirebaseFirestore.instance.collection("Comments").doc(widget.iid).get();

    setState(() {
      image = document["image"];
      description = document["name"];
      price = document["price"];
      category = document["category"];
      seller = sName["name"] + " " + sName["lname"];
      rating = ratingGet["rating"].toDouble();
      votes = ratingGet["total"];
      seller_id = document["uid"];
    });
  }




  Color _favIconColor = Colors.grey;
  Color _cartIconColor = Colors.grey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }


  @override
  Widget build(BuildContext context) {





    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(description!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(

        children: [
          SizedBox(height: 30),
          Center(
            child: ClipOval(

              child: CircleAvatar(
                backgroundImage: NetworkImage(image!),
                radius: 80,
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 55),
              IconButton(
                icon: Icon(Icons.star),
                iconSize: 50,
                color: _favIconColor,
                onPressed: () {
                  setState(() {
                    DatabaseService(uid: currentUser).updateFavData(widget.iid, category!, image!, description!, price!, seller_id);
                    if(_favIconColor == Colors.grey){
                      _favIconColor = Colors.amber;
                    }else{
                      _favIconColor = Colors.grey;
                    }
                  });
                },
              ),
              SizedBox(width: 45),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                iconSize: 50,
                color: _cartIconColor,
                onPressed: () {
                  DatabaseService(uid: currentUser).updateCartData(widget.iid, category!, image!, description!, price!, seller_id);

                  setState(() {
                    if(_cartIconColor == Colors.grey){
                      _cartIconColor = Colors.amber;
                    }else{
                      _cartIconColor = Colors.grey;
                    }
                  });
                },
              ),
              SizedBox(width: 40),
              MaterialButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Comments(iid: widget.iid)),
                  );

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.comment,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Column(
            children: [
              Text("Product Information",
                style: TextStyle( color: Colors.grey[500], fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text("Description: ",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(width: 14),
                  Flexible(
                    child: Text(
                      description!,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 13),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text("Category: ",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(width: 14),
                  Text(
                    category!,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 13),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text("Price: ",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(width: 14),
                  Text(
                    price!,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 13),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text("Seller: ",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(width: 14),
                  RichText(
                      text: TextSpan(
                          text: seller,
                        style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold, fontSize: 24,decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SellerProfile(uid: seller_id )),
                        )
                      )
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 50.0,
                direction: Axis.horizontal,
              ),
              SizedBox(width: 20,),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),


            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$votes Votes",
                style: TextStyle(

                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),





/*
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 230, 20),
            child: FlatButton(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {

                },
                child: Row(
                  children: [
                    Icon(
                      Icons.comment_sharp,

                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text("Comments")
                    ),


                  ],
                ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 230, 20),
            child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {

                },
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle,

                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("Seller Information")
                    ),

                  ],
                )),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 230, 20),
            child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {

                },
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,

                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("Add to Favs")
                    ),

                  ],
                )),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 230, 20),
            child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.amberAccent[400],
                onPressed: () {

                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_shopping_cart,

                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text("Add to Cart")
                    ),

                  ],
                )),
          ),*/

        ],

      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
