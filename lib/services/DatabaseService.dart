import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/UserModel.dart';


class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});



  final CollectionReference UserCollection = FirebaseFirestore.instance.collection("UserProfile");
  final CollectionReference ItemsCollection = FirebaseFirestore.instance.collection("Items");
  final CollectionReference CartCollection = FirebaseFirestore.instance.collection("Cart");


  Future updateUserData(String about,String name,String mail,String lname) async {
    return await UserCollection.doc(uid).set({
      "mail": mail,
      "name": name,
      "lname": lname,
      "about": about,
    });
  }

  Future updateCartData(String iid,String category,String image,String name,String price) async {
    return await CartCollection.doc(uid).collection("items").doc(iid).set({
      "category": category,
      "name": name,
      "price": price,
      "image": image,
      "uid": uid,
    });
  }

  Stream<QuerySnapshot> myItems() {
    var ref = ItemsCollection.where("uid",isEqualTo: uid).snapshots();

    return ref;
  }

  Stream<QuerySnapshot> getCart() {
    var ref = CartCollection.doc(uid).collection("items").snapshots();

    return ref;
  }





  Future<void> removeFromCart(String docId) {
    var ref = CartCollection.doc(uid).collection("items").doc(docId).delete();

    return ref;
  }

  Stream<QuerySnapshot> get users {
    return UserCollection.snapshots();
  }

}