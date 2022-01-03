import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/design/Dimensions.dart';
import 'package:project/design/TextStyles.dart';
import 'package:project/models/ItemPage.dart';
import 'package:project/services/DatabaseService.dart';
import 'package:project/services/itemsService.dart';
import 'package:project/routes/mapView.dart';


class PreviousOrderList extends StatefulWidget {
  const PreviousOrderList({Key? key}) : super(key: key);

  @override
  _PreviousOrderListState createState() => _PreviousOrderListState();
}

class _PreviousOrderListState extends State<PreviousOrderList> {

  itemsService _itemsService = itemsService();
  var currentUser = FirebaseAuth.instance.currentUser;


  List<DocumentSnapshot> data = [];


  Future<void> getPrevOrders()async {
    var document = await FirebaseFirestore.instance.collection("Transactions").where("buyer_uid",isEqualTo: currentUser!.uid).get();

    List<String> itemList = [];
    for(var doc in document.docs){
      itemList.add(doc.get("item_id"));

    }

    for(String s in itemList){
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Items").doc(s).get();
      setState(() {
        data.add(doc);

      });
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrevOrders();


  }



  Future<void> addComment(String iid,String comment) async{
    await FirebaseFirestore.instance.collection("Comments").doc(iid).collection("all").add({
      "comment":comment,
      "user_id":currentUser!.uid,
    });
  }




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        DocumentSnapshot post = data[index];

        Future<void> _askToComment(BuildContext context,String iid) {
          TextEditingController control = TextEditingController();
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(
                      "Please enter your comment.",
                      textAlign: TextAlign.center,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8.0))),
                    content: TextField(
                      controller: control,
                    ),
                  actions: [
                    MaterialButton(
                        onPressed: (){

                          addComment(iid, control.text);
                          Navigator.pop(context);
                        },
                      elevation: 5,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                );
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(post["image"]),
                        radius: size.height* 0.08,
                      ),
                      Flexible(
                        child: Text(
                          "${post["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ],

                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${post["price"]}",
                          style: TextStyle(
                            fontSize: 16,

                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: IconButton(
                            onPressed: (){

                            },
                            icon: Icon(
                              Icons.star_rate_rounded,
                              color: Colors.black,
                              size: 33,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: IconButton(
                            onPressed: (){

                              _askToComment(context,post.id);
                            },
                            icon: Icon(
                              Icons.rate_review_outlined,
                              color: Colors.black,
                              size: 33,
                            ),


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
  }
}