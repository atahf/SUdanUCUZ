import 'package:flutter/material.dart';
import 'routes/loading.dart';
import 'routes/Walkthrough.dart';
import 'routes/welcome.dart';
import 'routes/login.dart';
import 'routes/signup.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    "/": (context) => Loading(routeName: "/walkthrough"),
    "/walkthrough": (context) => Walkthrough(),
    "/welcome": (context) => Welcome(),
    "/login": (context) => Login(),
    "/signup": (context) => Signup(),
  },
));
