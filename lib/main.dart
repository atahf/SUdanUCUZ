import 'package:flutter/material.dart';
import 'routes/Walkthrough.dart';
import 'routes/loading.dart';
import 'routes/welcome.dart';
import 'routes/login.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    "/": (context) => Loading(routeName: "/walkthrough"),
    "/walkthrough": (context) => Walkthrough(),
    "/welcome": (context) => Welcome(),
    "/login": (context) => Login(),
  },
));
