import 'package:flutter/material.dart';

class promptbar extends StatelessWidget {
  const promptbar({
    super.key,
    required this.data,
    required this.fontsize
  });

  final data;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(200, 200, 200, 1)),
          borderRadius:
              BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SingleChildScrollView(
        child:
        
        Text(
          data,
          style: TextStyle(
              fontSize: fontsize,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(19, 61, 95, 1)),
        ),
      ),
    );
  }
}
