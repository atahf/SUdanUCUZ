import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project/design/ColorPalet.dart';

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
      backgroundColor: ColorPalet.main,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          Padding(
              padding: EdgeInsets.all(24),
              child: Container(
                child: Image.network("https://i.imgur.com/65OdlnF.jpg"),
              ),
          ),
          SpinKitSpinningLines(
            color: Colors.amberAccent,
            size: 75,
          ),
        ],
      ),
    );
  }
}