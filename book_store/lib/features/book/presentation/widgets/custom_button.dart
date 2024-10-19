import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final Color? textColor;
  final double? size;
  final double? rectangle;

  const CustomButton(
      {super.key,
      required this.name,
      required this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.size,
      this.rectangle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(rectangle ?? 10),
            )),
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(
              fontFamily: 'Schyler',
              fontSize: size ?? 18,
              color: textColor ?? Colors.white),
        ));
  }
}
