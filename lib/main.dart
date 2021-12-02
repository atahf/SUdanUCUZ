import 'package:flutter/material.dart';
import 'routes/loading.dart';
import 'routes/Walkthrough.dart';
import 'routes/welcome.dart';
import 'routes/login.dart';
import 'routes/signup.dart';
import "package:firebase_core/firebase_core.dart";


/*void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    "/": (context) => Loading(routeName: "/walkthrough"),
    "/walkthrough": (context) => Walkthrough(),
    "/welcome": (context) => Welcome(),
    "/login": (context) => Login(),
    "/signup": (context) => Signup(),
  },
));*/

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("No Firebase Connection!"),
                )
              )
            );
          }

          if(snapshot.connectionState == ConnectionState.done){
            runApp(MaterialApp(
              initialRoute: "/",
              routes: {
                "/": (context) => Loading(routeName: "/walkthrough"),
                "/walkthrough": (context) => Walkthrough(),
                "/welcome": (context) => Welcome(),
                "/login": (context) => Login(),
                "/signup": (context) => Signup(),
              },
            ));
          }

          return MaterialApp(
            home: Center(
              child: Text("Connecting to Firebase",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                backgroundColor: Colors.red,
              ),),
            ),
          );


        },);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FIREBASEEEEE"),
      ),
      body: Center(
        child: Text("Connected",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30),),
      ),
    );
  }
}

