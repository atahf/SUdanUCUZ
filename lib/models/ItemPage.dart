import 'dart:ffi';
import 'package:project/routes/Comments.dart';

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

  String? image = "";
  String? description = "";
  String? price = "";
  String? category = "";
  String? seller = "";


  Color _favIconColor = Colors.grey;
  Color _cartIconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {


    Future<void> setData() async{
      var document = await FirebaseFirestore.instance.collection("Items").doc(widget.iid).get();
      var sName = await FirebaseFirestore.instance.collection("UserProfile").doc(document["uid"]).get();



      setState(() {
        image = document["image"];
        description = document["name"];
        price = document["price"];
        category = document["category"];
        seller = sName["name"] + " " + sName["lname"];
      });
    }

    setData();
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
                  Text(
                    description!,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),
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
                  Text(
                    seller!,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40),

          Row(
            children: [
              SizedBox(width: 50),
              RaisedButton(onPressed: () {},
                  padding: EdgeInsets.all(15),
                  color: Colors.amberAccent[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text("Comments",
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),)
              ),
              SizedBox(width: 50),
              RaisedButton(onPressed: () {},
                  padding: EdgeInsets.all(15),
                  color: Colors.amberAccent[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text("Seller Info",
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),)
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
