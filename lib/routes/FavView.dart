import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/design/Dimensions.dart';
import 'package:project/design/TextStyles.dart';
import 'package:project/models/FavList.dart';
import 'package:project/models/ItemPage.dart';
import 'package:project/routes/addListing.dart';
import 'package:project/services/DatabaseService.dart';
import 'package:project/services/itemsService.dart';
import 'package:project/routes/mapView.dart';

import 'bottom.dart';


class FavView extends StatefulWidget {
  const FavView({Key? key}) : super(key: key);

  @override
  _FavView createState() => _FavView();
}

class _FavView extends State<FavView> {

  itemsService _itemsService = itemsService();
  var currentUser = FirebaseAuth.instance.currentUser;






  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],


        title: Row(
          children: [
            SizedBox(width: 75),
            Text("Favorites",style: appBarText,),

            SizedBox(width: 95),
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

              FavList(),

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