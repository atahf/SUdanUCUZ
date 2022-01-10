import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cmodel extends StatefulWidget {
  const Cmodel({Key? key,required this.cname}) : super(key: key);

  final String cname;

  @override
  State<Cmodel> createState() => _CmodelState();
}

class _CmodelState extends State<Cmodel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            color: Colors.blue,
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
