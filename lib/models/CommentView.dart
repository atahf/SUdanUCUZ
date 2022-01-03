import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/models/CommentModel.dart';
import 'package:project/services/itemsService.dart';








class CommentView extends StatefulWidget {
  const CommentView({Key? key,required this.iid}) : super(key: key);


  final String iid;

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {





  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: itemsService().getComments(widget.iid),
      builder: (context,snaphot){
        return !snaphot.hasData ? CircularProgressIndicator() : ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: snaphot.data!.docs.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            DocumentSnapshot post = snaphot.data!.docs[index];






            return CommentModel(post: post);
          },
        );
      },

    );
  }
}
