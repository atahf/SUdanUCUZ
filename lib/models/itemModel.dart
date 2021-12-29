import 'package:cloud_firestore/cloud_firestore.dart';

class item {
  String id;
  String name;
  String price;
  String image;
  String category;
  String uid;

  item({required this.id, required this.price,required this.image,required this.name,required this.category,required this.uid});

  factory item.fromSnapshot(DocumentSnapshot snapshot) {
    return item(
        id: snapshot.id,
        price: snapshot["price"],
        image: snapshot["image"],
        name: snapshot["name"],
        category: snapshot["category"],
        uid: snapshot["uid"],
    );
  }
}