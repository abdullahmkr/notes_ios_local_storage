import 'package:flutter/material.dart';

class HeadLine extends StatelessWidget {
  String text;
  double size;
  Color color;

  HeadLine(
      {Key? key, this.size = 30, required this.text, this.color = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
