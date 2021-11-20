import 'package:flutter/material.dart';
import 'routes/Walkthrough.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    "/": (context) => const Walkthrough(),
  },
));
