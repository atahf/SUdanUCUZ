import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/design/Dimensions.dart';
import 'package:project/design/TextStyles.dart';
import 'package:project/models/ItemPage.dart';
import 'package:project/routes/OrderDone.dart';
import 'package:project/services/DatabaseService.dart';
import 'package:project/services/itemsService.dart';
import 'package:project/routes/mapView.dart';


class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartView createState() => _CartView();
}

class _CartView extends State<CartView> {

  itemsService _itemsService = itemsService();
  var currentUser = FirebaseAuth.instance.currentUser;
  double total = 0;
  List<String> seller_list = [];
  List<String> item_list = [];


  Future<void> getTotal() async{
    var document = await FirebaseFirestore.instance.collection("Cart").doc(currentUser!.uid).collection("items").get();
    for(var doc in document.docs){

      setState(() {
        String pr = doc.get("price");
        pr = pr.substring(0,pr.length-1);
        var i = double.parse(pr);
        total += i ;
        seller_list.add(doc.get("uid"));
        item_list.add(doc.reference.id);
      });
    }
  }

  Future<void> makeTransaction() async{
    for(int x = 0; x < item_list.length;x++){
      await FirebaseFirestore.instance.collection("Transactions").add({
        "buyer_uid": currentUser!.uid,
        "seller_uid": seller_list[x],
        "item_id": item_list[x],
        "comment": "",
        "rate":0,
      });
    }
  }
  
  String currentTotal(double total) => "Total: "+ total.toStringAsFixed(2) +"\$";

  Future<void> deleteCart() async{
    var doc = await FirebaseFirestore.instance.collection("Cart").doc(currentUser!.uid).collection("items").get();
    for(var singleDoc in doc.docs){
      singleDoc.reference.delete();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
  }


  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "Cart",
          style: appBarText,
        ),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: DatabaseService(uid: currentUser!.uid ).getCart(),
              builder: (context,snaphot){
                return !snaphot.hasData ? CircularProgressIndicator() : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snaphot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    DocumentSnapshot post = snaphot.data!.docs[index];


                    Future<void> _askToRemove(BuildContext context) {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text(
                                  "Are you sure?",
                                  textAlign: TextAlign.center,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                                content: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).removeFromCart(post.id);
                                            setState(() {
                                              total = 0;
                                              getTotal();
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Remove",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )));
                          });
                    }

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
                                          _askToRemove(context);
                                        },
                                        icon: Icon(
                                            Icons.delete
                                        ),
                                        color: Colors.red,
                                        iconSize: 33,
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

            ),
                SizedBox(height: 25,),



          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          color:Colors.grey[800] ,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,

             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 25),
                 child: Text(
                     "${currentTotal(total)}",
                   style: TextStyle(
                     color: Colors.blue,
                     fontSize: 18,
                     fontWeight: FontWeight.bold
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(right: 25),
                 child: InkWell(
                   onTap: (){
                     makeTransaction();
                     deleteCart();
                     setState(() {
                       total = 0;
                     });
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => OrderDone()),
                     );

                   },
                   child: Container(
                     height: 50,
                     width: 150,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                       color: Colors.deepOrange,

                     ),
                     child: Center(
                         child: Text(
                           "Check Out",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 18,
                           ),
                         )
                     ),
                   ),
                 ),
               ),

             ],
           ),
          ],
        ),
      ) ,

    );
  }
}