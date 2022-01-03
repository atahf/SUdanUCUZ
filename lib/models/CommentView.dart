import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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



            return Padding(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Flexible(
                            child: Text(
                              "${post["comment"]}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],

                      ),






                    ],
                  ),

                ),
              ),
            );
          },
        );
      },

    );
  }
}
