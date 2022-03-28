import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String text;
  double size;
  Color color;

  AppText(
      {Key? key, this.size = 20, required this.text, this.color = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.black, fontSize: size),
    );
  }
}
