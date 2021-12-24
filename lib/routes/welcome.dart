import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/routes/feedView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loading.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:async';
import 'package:project/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> _setLogEvent() async {
    await widget.analytics.logEvent(name: "Welcome");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null){
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Welcome",
            style: appBarText,
          ),
          centerTitle: true,
          backgroundColor: ColorPalet.appBarColor,
        ),
        body: SafeArea(
          maintainBottomViewPadding: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(1.5, 2, 1.5, 1.75),
                  child: RichText(
                    text: const TextSpan(
                      text: "",
                    ),
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  child: Image.asset("assets/logo.jpg", fit: BoxFit.cover),
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.all(40.0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      FirebaseCrashlytics.instance.crash();
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Test CRASH',
                    ),
                  ),
                  style: mainBstyle,
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/signup");
                          _setLogEvent();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Signup',
                          ),
                        ),
                        style: mainBstyle,
                      ),
                    ),

                    const SizedBox(width: 8.0,),

                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                          _setLogEvent();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text("Login"),
                        ),
                        style: mainBstyle,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    else {
      return FeedView(analytics: analytics, observer: observer);

    }


  }
}
