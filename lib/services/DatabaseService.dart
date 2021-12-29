import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/UserModel.dart';


class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});



  final CollectionReference UserCollection = FirebaseFirestore.instance.collection("UserProfile");
  final CollectionReference ItemsCollection = FirebaseFirestore.instance.collection("Items");


  Future updateUserData(String about,String name,String mail,String lname) async {
    return await UserCollection.doc(uid).set({
      "mail": mail,
      "name": name,
      "lname": lname,
      "about": about,
    });
  }

  Stream<QuerySnapshot> myItems() {
    var ref = ItemsCollection.where("uid",isEqualTo: uid).snapshots();

    return ref;
  }






  Stream<QuerySnapshot> get users {
    return UserCollection.snapshots();
  }

}