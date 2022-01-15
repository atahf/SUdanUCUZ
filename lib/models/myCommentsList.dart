import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/models/CommentModel.dart';
import 'package:project/models/MyCommentModel.dart';
import 'package:project/services/DatabaseService.dart';
import 'package:project/services/itemsService.dart';








class MyCommentView extends StatefulWidget {
  const MyCommentView({Key? key}) : super(key: key);




  @override
  _MyCommentViewState createState() => _MyCommentViewState();
}

class _MyCommentViewState extends State<MyCommentView> {





  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getMyComments(),
      builder: (context,snaphot){
        return !snaphot.hasData ? CircularProgressIndicator() : ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: snaphot.data!.docs.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            DocumentSnapshot post = snaphot.data!.docs[index];






            return MyCommentModel(post: post);
          },
        );
      },

    );
  }
}