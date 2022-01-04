import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/routes/bottom.dart';





class SellerProfile extends StatefulWidget {
  const SellerProfile({Key? key,required this.uid}) : super(key: key);

  final String uid;

  @override
  _SellerProfileState createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {

  String name = "";
  String about = "";
  String pp = "";
  int total = 0;
  double rating = 0;

  Future<void> getUserData() async {
    var document = await FirebaseFirestore.instance.collection("UserProfile").doc(widget.uid).get();
    setState(() {
      name = document["name"] + " " + document["lname"];
      about = document["about"];
      pp = document["pp"];
      total = document["total_sale"];
      rating = document["rating"];
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
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
            Text("Seller Profile",
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
                      rating.toStringAsFixed(1),
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
                      total.toString(),
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
