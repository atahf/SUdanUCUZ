import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/UserModel.dart';


class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});



  final CollectionReference UserCollection = FirebaseFirestore.instance.collection("UserProfile");
  final CollectionReference ItemsCollection = FirebaseFirestore.instance.collection("Items");
  final CollectionReference CartCollection = FirebaseFirestore.instance.collection("Cart");
  final CollectionReference FavoriteCollection = FirebaseFirestore.instance.collection("Favorites");
  final CollectionReference TransactionCollection = FirebaseFirestore.instance.collection("Transactions");




  Future updateUserData(String about,String name,String mail,String lname) async {
    return await UserCollection.doc(uid).set({
      "mail": mail,
      "name": name,
      "lname": lname,
      "about": about,
      "pp": "https://firebasestorage.googleapis.com/v0/b/sudanucuz-2e0a6.appspot.com/o/indir.jpg?alt=media&token=f2b65994-b332-444a-bc54-4b6697cf84c3",
      "total_sale": 0,
      "rating": 0.0
    });
  }

  Future updateCartData(String iid,String category,String image,String name,String price,String id) async {
    return await CartCollection.doc(uid).collection("items").doc(iid).set({
      "category": category,
      "name": name,
      "price": price,
      "image": image,
      "uid": id,
    });
  }

  Future updateFavData(String iid,String category,String image,String name,String price) async {
    return await FavoriteCollection.doc(uid).collection("items").doc(iid).set({
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

  Stream<QuerySnapshot> getFavs() {
    var ref = FavoriteCollection.doc(uid).collection("items").snapshots();

    return ref;
  }

   





  Future<void> removeFromCart(String docId) {
    var ref = CartCollection.doc(uid).collection("items").doc(docId).delete();

    return ref;
  }

  Future<void> removeFromFav(String docId) {
    var ref = FavoriteCollection.doc(uid).collection("items").doc(docId).delete();

    return ref;
  }

  Stream<QuerySnapshot> get users {
    return UserCollection.snapshots();
  }



}