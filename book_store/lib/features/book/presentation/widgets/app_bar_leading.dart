import 'package:flutter/material.dart';

class AppBarLeading extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final Color backgroundColor;
  final TextStyle? titleTextStyle;
  final bool? autoLeading;
  final List<Widget>? actions;
  final Widget?
      customLeadingIcon; // Add this parameter for the custom leading icon

  const AppBarLeading({
    super.key,
    required this.title,
    this.centerTitle,
    this.backgroundColor = Colors.white,
    this.titleTextStyle,
    this.actions,
    this.autoLeading,
    this.customLeadingIcon, // Initialize the leading icon
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false, // Disable default leading
      centerTitle: centerTitle,
      title: Row(
        children: [
          if (customLeadingIcon != null) customLeadingIcon!,
          const SizedBox(
            width: 10,
          ), // Add custom icon
          Expanded(
            child: Text(
              title,
              style: titleTextStyle ??
                  const TextStyle(
                    fontSize: 35,
                    fontFamily: 'Schyler',
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
