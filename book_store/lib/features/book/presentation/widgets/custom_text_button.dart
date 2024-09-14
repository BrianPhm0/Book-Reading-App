import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool underlineCheck;

  const CustomTextButton({
    super.key,
    required this.name,
    required this.onPressed,
    required this.underlineCheck,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        disabledBackgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Schyler',
          fontSize: 18,
          decoration:
              underlineCheck ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
