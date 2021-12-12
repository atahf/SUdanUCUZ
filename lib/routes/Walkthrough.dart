import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:project/design/ColorPalet.dart';
import 'package:project/design/TextStyles.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/design/Dimensions.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  int current = 1;
  int last = 4;


  List <String> Title = [
    "Welcome",
    "Purpose",
    "Get Started",
    "Buy/Sell",
  ];

  List <String> Links = [
    "https://i.imgur.com/65OdlnF.jpg",
    "https://cdn5.vectorstock.com/i/1000x1000/44/19/woman-with-shopping-cart-and-products-vector-22394419.jpg",
    "https://cdn5.vectorstock.com/i/1000x1000/44/19/woman-with-shopping-cart-and-products-vector-22394419.jpg",
    "https://cdn5.vectorstock.com/i/1000x1000/44/19/woman-with-shopping-cart-and-products-vector-22394419.jpg"
  ];

  List <String> SemiTitle = [
    "Welcome to SUdanUcuz",
    "The Purpose of the App",
    "First Things First",
    "Buy/Sell Easily",
  ];

  List <String> Descriptions = [
    "Here is little tour for you to getting familiar with the App",
    "The purpose of the SUdanUcuz App is to make transactions easier for SU members.",
    "The first thing you should do is identifying yourself by Signing Up.",
    "After logging in you can immediately start making transactions."
  ];

  void next(){
    if (current-1 < 3){
      setState(() {
        current++;
      });
    }
    else {
      Navigator.pushNamed(context, "/welcome");
    }
  }

  void previous(){
    if (current>1){
      setState(() {
        current--;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalet.divider,
      appBar: AppBar(
        title: Text(
            Title[current-1],
            style: appBarText
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: Dimensions.regularPadding,
            child: ClipRect(
                child: Image.network(Links[current-1])
            ),
          ),
          Divider(
            thickness: 3,
            color: Colors.white70,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: Dimensions.regularPadding,
                  child: Text(
                      SemiTitle[current-1],
                      style: semiTitlestyle
                  ),
                ),

              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(

                    border: Border(
                        bottom: BorderSide(),
                        top: BorderSide()
                    ),
                  ),
                  child: Center(
                    child: Text(
                      Descriptions[current-1],
                      style:generalTextStyle,
                      textAlign: TextAlign.center ,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.autoLeft,0,0,Dimensions.autoBottom),
                  child: OutlinedButton(
                      onPressed: (){previous();},
                      child: Text("Prev"),
                      style: mainBstyle
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,Dimensions.autoBottom),
                  child: Text(
                      "$current/4",
                      style: generalTextStyle
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,Dimensions.autoRight,Dimensions.autoBottom),
                  child: OutlinedButton(
                      onPressed: (){next();},
                      child: Text("Next"),
                      style: mainBstyle
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}