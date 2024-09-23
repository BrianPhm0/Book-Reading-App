import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double? size; // Optional size parameter
  final Color? color; // Optional color parameter

  const Loader({super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 5.0, // You can adjust the stroke width
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Theme.of(context).primaryColor, // Default to primary color
        ),
        // You can set a size if needed, otherwise it'll be circular
        value: size != null ? null : 1.0,
      ),
    );
  }
}
