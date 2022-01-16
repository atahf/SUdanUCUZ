import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/design/TextStyles.dart';
import 'package:project/models/ItemPage.dart';
import 'package:project/routes/mapView.dart';
import 'package:project/services/DatabaseService.dart';
import 'package:project/services/itemsService.dart';




class SearchView2 extends StatefulWidget {
  SearchView2({required this.query});

  final TextEditingController query;
  @override
  _SearchView2State createState() => _SearchView2State();
}

class _SearchView2State extends State<SearchView2> {


  List<DocumentSnapshot> data = [];

  Future fillData() async {
    data = await itemsService().getStatusSearch1(widget.query.text);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillData();
    print(widget.query.text);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "Search Result",
          style: appBarText,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          DocumentSnapshot post = data[index];

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemPage(iid: post.id)),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal:5,
                ),
                padding: EdgeInsets.symmetric(horizontal:10,vertical:15),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.amberAccent[400],

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(

                  children: [
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.start,


                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(post["image"]),
                          radius: 70,
                        ),
                        Flexible(
                          child: Center(
                            child: Text(
                                "${post["name"]}\n\n${post["price"]}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),
                                textAlign: TextAlign.center

                            ),
                          ),
                        ),

                      ],

                    ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,0,0),
                            child: IconButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MapApp(
                                    camPosition: LatLng(40.889550,29.374065),
                                    title: "${post["name"]}",
                                    price: "${post["price"]}",
                                  )),
                                  //TODO have to add LatLng values to each item
                                );
                              },
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.red,
                                size: 33,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,0,0),
                            child: IconButton(
                              onPressed: (){
                                DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).updateFavData(post.id,post["category"] , post["image"], "${post["name"]}", "${post["price"]}","${post["uid"]}")
                                    .then((value) {
                                  Fluttertoast.showToast(
                                      msg: "Succesfully added to Favorites",
                                      timeInSecForIosWeb: 2,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.grey[600],
                                      textColor: Colors.white,
                                      fontSize: 14);

                                });
                              },
                              icon: Icon(
                                Icons.star_border,
                                color: Colors.grey[900],
                                size: 33,
                              ),


                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,0,0),
                            child: TextButton.icon(
                              onPressed: (){
                                DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).updateCartData(post.id,post["category"] , post["image"], "${post["name"]}", "${post["price"]}","${post["uid"]}");

                              },
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.grey[900],
                                size: 33,
                              ),
                              label: Text(""),


                            ),
                          ),

                        ],
                      ),
                    ),




                  ],
                ),

              ),
            ),
          );
        },
      )
    );
  }
}
