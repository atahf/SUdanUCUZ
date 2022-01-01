import 'dart:ffi';

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


  @override
  Widget build(BuildContext context) {


    Future<void> setData() async{
      var document = await FirebaseFirestore.instance.collection("Items").doc(widget.iid).get();


      setState(() {
        image = document["image"];
        description = document["name"];
        price = document["price"];
        category = document["category"];
      });
    }

    setData();
    return Column(
      children: [
        Row(
          children: [
            Text(description!,style: TextStyle(color: Colors.white)),
          ],

        ),
        Row(
          children: [
            Text(category!,style: TextStyle(color: Colors.white)),
          ],
        ),
        Row(
          children: [
            Text(price!,style: TextStyle(color: Colors.white),),
          ],
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image!),
              radius: 45,
            ),
          ],
        ),
      ],
    );
  }
}
