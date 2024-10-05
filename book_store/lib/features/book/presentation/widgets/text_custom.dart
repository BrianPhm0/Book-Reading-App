import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final int? maxLines; // Added maxLines
  final TextOverflow? textOverflow; // Added textOverflow

  const TextCustom({
    super.key,
    required this.text,
    this.fontFamily,
    required this.fontSize,
    required this.color,
    this.fontWeight,
    this.maxLines, // Add these to the constructor
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines, // Implement maxLines
      overflow: textOverflow, // Implement textOverflow
      style: TextStyle(
        fontSize: fontSize,
        fontFamily:
            fontFamily ?? 'Schyler', // Default to 'Schyler' if not provided
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
