import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');


}