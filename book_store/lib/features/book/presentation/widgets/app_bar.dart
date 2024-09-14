import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final Color backgroundColor;
  final TextStyle? titleTextStyle;
  final bool? autoLeading;

  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle,
    this.backgroundColor = Colors.white,
    this.titleTextStyle,
    this.actions,
    this.autoLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: titleTextStyle ??
            const TextStyle(
              fontSize: 35,
              fontFamily: 'Schyler',
              fontWeight: FontWeight.bold,
            ),
      ),
      automaticallyImplyLeading: autoLeading ?? true,
      centerTitle: centerTitle,
      backgroundColor: Colors.white,
      actions: actions,
      titleTextStyle: const TextStyle(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
