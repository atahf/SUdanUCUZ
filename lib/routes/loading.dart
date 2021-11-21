import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//loading page
class Loading extends StatefulWidget {
  final String routeName;

  const Loading({Key? key, required this.routeName}): super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void goPage() async {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, widget.routeName);
    });
  }

  @override
  void initState() {
    super.initState();
    goPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SpinKitSpinningLines(
            color: Colors.amberAccent,
            size: 75,
          ),
        ],
      ),
    );
  }
}