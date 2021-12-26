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
              var route = ModalRoute.of(context);
              if(route!.settings.name!=null) {
                print(route.settings.name);
                if ("/feedview" != route.settings.name && "/login" != route.settings.name) {
                  Navigator.pop(context);
                }
              }
              else {
                Navigator.pop(context);
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
              var route = ModalRoute.of(context);
              if(route!.settings.name!=null) {
                if ("/profile" != route.settings.name) {
                  Navigator.pushNamed(context, "/profile");
                }
              }
              else {
                Navigator.pushNamed(context, "/profile");
              }
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


