import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/loading.dart';
import 'routes/Walkthrough.dart';
import 'routes/welcome.dart';
import 'routes/login.dart';
import 'routes/signup.dart';
import 'routes/feedView.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import 'package:after_layout/after_layout.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
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
          runApp (StreamProvider<User?>.value(
            value: AuthService().user,
            initialData: null,
            child: MaterialApp(
              navigatorObservers: <NavigatorObserver>[observer],
              initialRoute: "/",
              routes: {
                "/": (context) => const Loading(routeName: "/splash"),
                "/walkthrough": (context) => Walkthrough(analytics: analytics,observer: observer),
                "/welcome": (context) => Welcome(analytics: analytics,observer: observer),
                "/login": (context) => Login(analytics: analytics,observer: observer),
                "/signup": (context) => Signup(analytics: analytics,observer: observer),
                "/splash": (context) => Splash(),
                "/feedview": (context) => FeedView(analytics: analytics,observer: observer),
              },
            ),
          ));
        }

        return const MaterialApp(
          home: Center(
            child: SpinKitSpinningLines(
              color: Colors.amberAccent,
              size: 75,
            ),
          ),
        );

      },
    );
  }


}

class Splash extends StatefulWidget {

  @override
  SplashState createState() => new SplashState();



}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Welcome(analytics: analytics,observer: observer)));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Walkthrough(analytics: analytics,observer: observer)));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
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

