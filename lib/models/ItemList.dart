import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/design/Dimensions.dart';
import 'package:project/design/TextStyles.dart';
import 'package:project/models/ItemPage.dart';
import 'package:project/services/DatabaseService.dart';
import 'package:project/services/itemsService.dart';
import 'package:project/routes/mapView.dart';


class ItemList extends StatefulWidget {
  const ItemList({Key? key,required this.category,required this.order}) : super(key: key);

  final String category;
  final String order;

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  itemsService _itemsService = itemsService();

  Future showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Location Warning",
              style: appBarText,
            ),
            content: SingleChildScrollView(
              child: Column(
                children: const [
                  Text("Seller of this product has not mentioned any address!"),

                  //MapApp(),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Dismiss"),
              ),
            ],
          );
        }
    );
  }

  Future setLoc(String seller,BuildContext context,String iid)async{
    var doc1 = await FirebaseFirestore.instance.collection("Items").doc(iid).get();
    String price = doc1["price"];
    String name = doc1["name"];
    var doc = await FirebaseFirestore.instance.collection("Locations").doc(seller).get();
    LatLng x;
    try {
      x = LatLng(doc["alt"],doc["long"]);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapApp(
          camPosition: x ,
          price: price,
          title: name,

        )),
      );
    }
    catch (e) {
      showAlertDialog(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: _itemsService.getStatus(widget.category,widget.order),
      builder: (context,snaphot){
        return !snaphot.hasData ? CircularProgressIndicator() : ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: snaphot.data!.docs.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            DocumentSnapshot post = snaphot.data!.docs[index];




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
                                    setLoc(post["uid"], context,post.id);
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
        );
      },

    );
  }
}
