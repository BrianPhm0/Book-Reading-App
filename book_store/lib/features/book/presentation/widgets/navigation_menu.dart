import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;
  final Color? backgroudColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? iconSize;
  const NavigationMenu(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.items,
      this.backgroudColor,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.iconSize});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.items,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      backgroundColor: widget.backgroudColor,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      iconSize: widget.iconSize ?? 30.0,
      type: BottomNavigationBarType.fixed,
    );
  }
}
