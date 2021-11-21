import 'package:flutter/material.dart';
import 'routes/Walkthrough.dart';
import 'routes/loading.dart';
import 'routes/login.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    "/": (context) => const Loading(routeName: "/walkthrough"),
    "/walkthrough": (context) => const Walkthrough(),
    "/login": (context) => const Login(),
  },
));
