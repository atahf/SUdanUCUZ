import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/models/itemModel.dart';
import 'package:project/services/itemStorage.dart';




class itemsService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  itemStorage _itemStorage = itemStorage();
  String mediaUrl = "";


  Future<item> addItem(String name,XFile pickedFile,String price)async{
    var ref = _firestore.collection("Items");

    mediaUrl = await _itemStorage.uploadMedia(File(pickedFile.path));
    var documentRef = await ref.add({
      "name": name,
      "image": mediaUrl,
      "price": price
    });

    return item(id: documentRef.id,name:name,image:mediaUrl,price: price);
  }


  //status göstermek için
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Items").snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Items").doc(docId).delete();

    return ref;
  }


}