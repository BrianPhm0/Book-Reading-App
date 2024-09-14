import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNav extends StatefulWidget {
  final Color background;
  final Color color;
  final Color activeColor;
  final List<GButton> items;
  final double? gap;
  final ValueChanged<int> onTap;

  const CustomBottomNav(
      {super.key,
      required this.background,
      required this.color,
      required this.activeColor,
      required this.items,
      this.gap,
      required this.onTap});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return GNav(
      tabs: widget.items,
      backgroundColor: widget.background,
      activeColor: widget.activeColor,
      gap: widget.gap ?? 0,
      onTabChange: widget.onTap,
    );
  }
}
