import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cmodel extends StatefulWidget {
  const Cmodel({Key? key,required this.cname,required this.color}) : super(key: key);

  final String cname;
  final String color;


  @override
  State<Cmodel> createState() => _CmodelState();
}

class _CmodelState extends State<Cmodel> {

  MaterialColor colorMake(){
    if (widget.color == "blue"){
      return Colors.blue;
    }
    else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorMake(),
          border: Border.all(
            color: colorMake(),
          ),
          borderRadius: BorderRadius.circular(12),

        ),
        height: 25,
        width: 125,
        child: Center(
          child: Text(
            widget.cname,
            style: TextStyle(
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      ),
    );
  }
}
