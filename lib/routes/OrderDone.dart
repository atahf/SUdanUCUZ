import 'package:flutter/material.dart';
import 'package:project/design/TextStyles.dart';


class OrderDone extends StatelessWidget {
  const OrderDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "Success",
          style: appBarText,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.done_rounded,color: Colors.green,size: 70,),
                SizedBox(width: 25,),
                Text(
                  "Your purchase was succesful.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton.icon(onPressed: (){Navigator.pushNamed(context, "/feedview");}, icon: Icon(Icons.home,size: 30,color: Colors.white,),label: Text("Get back to Home",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),)
                ],
              )
          ),
        ],
      ),
    );
  }
}
