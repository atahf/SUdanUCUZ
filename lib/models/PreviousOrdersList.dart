import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';



class PreviousOrderList extends StatefulWidget {
  const PreviousOrderList({Key? key}) : super(key: key);

  @override
  _PreviousOrderListState createState() => _PreviousOrderListState();
}

class _PreviousOrderListState extends State<PreviousOrderList> {

  itemsService _itemsService = itemsService();
  var currentUser = FirebaseAuth.instance.currentUser;
  double rating = 0;


  List<DocumentSnapshot> data = [];


  Future<void> getPrevOrders()async {
    //Transactionlar içinde kullanıcıya ait olan satın alımları çekiyorum.
    var document = await FirebaseFirestore.instance.collection("Transactions").where("buyer_uid",isEqualTo: currentUser!.uid).get();

    // Bu satın alımlarda hangi id'li itemin alındığı bilgisini buluyorum.
    List<String> itemList = [];
    for(var doc in document.docs){
      itemList.add(doc.get("item_id"));

    }

    // Bu itemlerin datasını teker teker çekiyorum.
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



  Future addComment(String iid,String comment,double rating) async{
    
    var doc = await FirebaseFirestore.instance.collection("Comments").doc(iid).collection("all").where("user_id", isEqualTo:currentUser!.uid ).get();

    //Kullanıcı daha önce aynı ürünü değerlendirmiş diye kontrol ediyorum, eğer değerlendirmişse uyarı veriyorum.
    if (doc.docs.isNotEmpty){
      return Fluttertoast.showToast(
          msg: "You've already rated this product.",
          timeInSecForIosWeb: 2,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[600],
          textColor: Colors.white,
          fontSize: 14);
    }
    
    //Comment, commenti kimin attığı ve verilen ratingi database'e gönderiyorum.
    await FirebaseFirestore.instance.collection("Comments").doc(iid).collection("all").add({
      "comment":comment,
      "user_id":currentUser!.uid,
      "rating": rating
    });

    //Comments klasörünün içindeki her bir item'ın rating ve total değişkeni olmasını sağlıyorum.
    //var doc = await FirebaseFirestore.instance.collection("Comments").doc(iid).get();
    /*if(!doc.data()!.containsKey("total")){
      await FirebaseFirestore.instance.collection("Comments").doc(iid).set({
        "total" : 0,
        "rating" : 0
      });
    }*/

    //Verilen ratinge göre itemin ratingini ve toplam kaç kişinin oyladığını güncelliyorum.
    var doc1 = await FirebaseFirestore.instance.collection("Comments").doc(iid).get();
    int ttl = doc1.get("total")+1;
    var rate = (doc1.get("rating")*(ttl-1)+rating)/ttl;
    await FirebaseFirestore.instance.collection("Comments").doc(iid).update({"total":ttl});
    await FirebaseFirestore.instance.collection("Comments").doc(iid).update({"rating":rate});

    
  }
  
  Future<void> updateSellerProfile(String uid) async{
    // Seller'ın datasını çekiyorum ve gerekli güncellemeleri yapıyorum.
    var document = await FirebaseFirestore.instance.collection("UserProfile").doc(uid).get();
    int sale = document.get("total_sale")+1;
    var rate = (document.get("rating")*(sale-1)+rating)/sale;
    await FirebaseFirestore.instance.collection("UserProfile").doc(uid).update({"total_sale":sale});
    await FirebaseFirestore.instance.collection("UserProfile").doc(uid).update({"rating":rate});


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
                    title: Column(
                      children: [
                        Text(
                          "Rate the Product.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10,),
                        buildRating(),

                        Text(
                          "Please enter your comment.",
                          textAlign: TextAlign.center,
                        ),
                      ],
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

                          addComment(iid, control.text,rating);
                          updateSellerProfile(post["uid"]);
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
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: TextButton.icon(
                            onPressed: (){

                              _askToComment(context,post.id);
                            },
                            icon: Icon(
                              Icons.rate_review_outlined,
                              color: Colors.black,
                              size: 33,
                            ),
                            label: Text("Review",style: TextStyle(color: Colors.black),),


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
  Widget buildRating(){
    return RatingBar.builder(
        minRating: 1,
        itemSize: 30,
        itemPadding: EdgeInsets.symmetric(horizontal: 1),
        itemBuilder: (context,_)=>Icon(Icons.star,color: Colors.amber),
        onRatingUpdate: (rating) => setState(() {
          this.rating = rating;
          print(this.rating);
        })
    );
  }
}


