import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;
  const TextCustom(
      {super.key,
      required this.text,
      this.fontFamily,
      required this.fontSize,
      required this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Schyler',
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
