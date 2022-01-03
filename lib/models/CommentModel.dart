import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';






class CommentModel extends StatefulWidget {
  const CommentModel({Key? key,required this.post}) : super(key: key);

  final DocumentSnapshot post;

  @override
  _CommentModelState createState() => _CommentModelState();
}

class _CommentModelState extends State<CommentModel> {

  String name = "";
  String photo = "";


  Future<void> setC() async {
    var doc = await FirebaseFirestore.instance.collection("UserProfile").doc(widget.post["user_id"]).get();
    name = doc["name"] + " " +doc["lname"];
    photo = doc["pp"];
    print(name);
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setC();
  }






  @override
  Widget build(BuildContext context) {
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
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blue,

            borderRadius: BorderRadius.circular(20),
          ),

          child: Column(

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Flexible(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RatingBarIndicator(
                    rating: widget.post["rating"],
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  ),

                ],

              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(photo),
                      radius: 45,
                    ),
                  ),
                  Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25,15,0,0),
                        child: Text(
                            "${widget.post["comment"]}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                  ),
                ],
              )






            ],
          ),

        ),
      ),
    );
  }
}
