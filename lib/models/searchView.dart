import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/design/TextStyles.dart';
import 'package:project/services/itemsService.dart';




class SearchView extends StatefulWidget {
  SearchView({required this.query});

  final TextEditingController query;
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {



  itemsService _itemsService = itemsService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      color: Colors.grey[900],
      child: StreamBuilder<QuerySnapshot>(
        stream: _itemsService.getStatusSearch(widget.query.text),
        builder: (context,snaphot){
          return !snaphot.hasData ? CircularProgressIndicator() : ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: snaphot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context,index){
              DocumentSnapshot post = snaphot.data!.docs[index];

              return Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){},
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
                            CircleAvatar(
                              backgroundImage: NetworkImage(post["image"]),
                              radius: size.height* 0.08,
                            ),
                            Flexible(
                              child: Text(
                                "${post["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          ],

                        ),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${post["price"]}",
                                style: TextStyle(
                                  fontSize: 16,

                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(40,0,0,0),
                                child: OutlinedButton(
                                    onPressed: (){},
                                    child: Text("Add2Cart"),
                                    style: mainBstyle
                                ),
                              ),
                            ],
                          ),
                        ),




                      ],
                    ),

                  ),
                ),
              );
            },
          );
        },

      ),
    );
  }
}
