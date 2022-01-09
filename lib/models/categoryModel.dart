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
    return Container(
      height: 25,
      width: 35,
      child: Text(
        widget.cname,
      ),
    );
  }
}
