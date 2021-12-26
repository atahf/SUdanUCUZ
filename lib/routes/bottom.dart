import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "../routes/account.dart";
import 'package:path/path.dart';

class Bottom extends StatelessWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30,
      backgroundColor: Colors.grey[900],
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: MaterialButton(
            onPressed: () {
              //Navigator.pop(context);

              var route = ModalRoute.of(context);
              print(route);
              print("fsfsdfsdf");
              if(route!=null) {
                if ("/feedview" != route.settings.name) {
                  Navigator.pushNamed(context, "/feedview");
                }
                else{
                  Navigator.pop(context);
                }
              }
              else{
                Navigator.pushNamed(context, "/feedview");
              }





            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: Colors.amberAccent[400],
                ),

              ],
            ),
          ),
          title: Text(
            "Home",
            style: TextStyle(fontSize: 15,color: Colors.grey[400],fontWeight: FontWeight.bold),
          ),
        ),

        BottomNavigationBarItem(
          icon: MaterialButton(
            onPressed: () {
              //Navigator.pushNamed(context, "/feedview");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.amberAccent[400],
                ),

              ],
            ),
          ),
          title: Text(
            "Favorites",
            style: TextStyle(fontSize: 15,color: Colors.grey[400],fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: MaterialButton(
            onPressed: () {
              //Navigator.pushNamed(context, "/feedview");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  color: Colors.amberAccent[400],
                ),



              ],
            ),
          ),
          title:  Text(
            "Cart",
            style: TextStyle(fontSize: 15,color: Colors.grey[400],fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/profile");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.account_circle_outlined,
                  color: Colors.amberAccent[400],
                ),


              ],
            ),
          ),
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 15,color: Colors.grey[400],fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}


