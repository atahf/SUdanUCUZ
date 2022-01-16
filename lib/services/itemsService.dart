import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/models/itemModel.dart';
import 'package:project/services/itemStorage.dart';




class itemsService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  itemStorage _itemStorage = itemStorage();
  String mediaUrl = "";


  Future<item> addItem(String name,XFile pickedFile,String price,String category,String uid)async{
    var ref = _firestore.collection("Items");

    mediaUrl = await _itemStorage.uploadMedia(File(pickedFile.path));
    var documentRef = await ref.add({
      "name": name,
      "image": mediaUrl,
      "price": price,
      "category": category,
      "uid":uid,
      "pricen": makeItDouble(price),
    });
    await FirebaseFirestore.instance.collection("Comments").doc(documentRef.id).set({
      "total" : 0,
      "rating" : 0,
    });

    return item(id: documentRef.id,name:name,image:mediaUrl,price: price,category: category,uid: uid);
  }


  //status göstermek için
  Stream<QuerySnapshot> getStatus(String s,String order) {
    if (s == "all"){
      if (order == "n"){
        var ref = _firestore.collection("Items").snapshots();

        return ref;
      }
      else if (order == "a"){
        var ref = _firestore.collection("Items").orderBy("pricen",descending: false).snapshots();

        return ref;
      }
      else {
        var ref = _firestore.collection("Items").orderBy("pricen",descending: true).snapshots();

        return ref;
      }
    }
    else {
      if (order == "n"){
        var ref = _firestore.collection("Items").where("category",isEqualTo: s).snapshots();

        return ref;
      }
      else if (order == "a"){
        var ref = _firestore.collection("Items").where("category",isEqualTo: s).orderBy("pricen",descending: false).snapshots();

        return ref;
      }
      else {
        var ref = _firestore.collection("Items").where("category",isEqualTo: s).orderBy("pricen",descending: true).snapshots();

        return ref;
      }
    }
  }

  Stream<QuerySnapshot> getStatusSearch(String query) {
    var ref = _firestore.collection("Items").where("name",isGreaterThanOrEqualTo: query).where("name",isLessThan: query +"z").snapshots();

    return ref;
  }

  Future <List<DocumentSnapshot>> getStatusSearch1(String query)async {
    var ref = await _firestore.collection("Items").get();
    List<DocumentSnapshot> items = [];
    for(var doc in ref.docs){
      if (contains(query, doc["name"])){

        items.add(doc);
      }
    }

    return items;
  }
  
  Stream<QuerySnapshot> getComments(String iid) {
    var ref = _firestore.collection("Comments").doc(iid).collection("all").snapshots();

    return ref;
  }



  //status silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Items").doc(docId).delete();

    return ref;
  }

  bool contains(String a, String b){
    return  b.toLowerCase().replaceAll(" ", "").contains(a.toLowerCase().replaceAll(" ", ""));
  }
  
  double makeItDouble(String pr){
    String ps = pr.substring(0,pr.length-1);
    var i = double.parse(ps);
    return i;
  }


}