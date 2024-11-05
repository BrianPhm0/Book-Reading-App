import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final Color backgroundColor;
  final TextStyle? titleTextStyle;
  final bool? autoLeading;
  final Widget? leading;

  final List<Widget>? actions;
  final PreferredSizeWidget? tabs;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle,
    this.backgroundColor = Colors.white,
    this.titleTextStyle,
    this.actions,
    this.autoLeading,
    this.leading,
    this.tabs,
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
      leading: leading,
      automaticallyImplyLeading: autoLeading ?? true,
      centerTitle: centerTitle,
      backgroundColor: Colors.white,
      actions: actions,
      titleTextStyle: const TextStyle(color: Colors.black),
      bottom: tabs,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
