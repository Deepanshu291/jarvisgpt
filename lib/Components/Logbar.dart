import 'package:flutter/material.dart';

// ignore: must_be_immutable
class logbar extends StatelessWidget {
   logbar({
    super.key,
    required this.desc
  });
  String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            desc,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}
