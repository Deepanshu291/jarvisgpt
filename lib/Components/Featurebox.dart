import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  const FeatureBox({super.key , required this.color, required this.title,  required this.desc});

  final Color color;
  final String title;
  final String desc;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20).copyWith(top: 30, bottom: 30),
      margin: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            desc,
            style: TextStyle(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
