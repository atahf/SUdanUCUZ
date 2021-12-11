import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/loading.dart';
import 'routes/Walkthrough.dart';
import 'routes/welcome.dart';
import 'routes/login.dart';
import 'routes/signup.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyFirebaseApp());
}


class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);



  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {

  final Future <FirebaseApp> _initialization = Firebase.initializeApp();

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
        if(snapshot.hasError){
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("No Firebase Connection!"),
              )
            )
          );
        }

        if(snapshot.connectionState == ConnectionState.done){
          runApp (MaterialApp(
            navigatorObservers: <NavigatorObserver>[observer],
            initialRoute: "/welcome",
            routes: {
              "/walkthrough": (context) => Walkthrough(analytics: analytics,observer: observer),
              "/welcome": (context) => Welcome(analytics: analytics,observer: observer),
              "/login": (context) => Login(analytics: analytics,observer: observer),
              "/signup": (context) => Signup(analytics: analytics,observer: observer),
            },
          ));
        }

        return MaterialApp(
          home: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    child: Image.asset("assets/logo.jpg", fit: BoxFit.cover),
                  ),
                ),
                const SpinKitSpinningLines(
                  color: Colors.amberAccent,
                  size: 75,
                ),
              ],
            ),
          ),
        );

      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FIREBASEEEEE"),
      ),
      body: const Center(
        child: Text(
          "Connected",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),
        ),
      ),
    );
  }
}

