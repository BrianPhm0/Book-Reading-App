import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String? content,
    {String? actionLabel, VoidCallback? action}) {
  if (content == null || content.isEmpty) {
    return; // Exit early if content is null or empty
  }

  final snackBar = SnackBar(
    content: Text(content),
    duration: const Duration(
        seconds: 3), // Specify how long the snackbar should be displayed
    action: actionLabel != null && action != null
        ? SnackBarAction(
            label: actionLabel,
            onPressed: action,
          )
        : null,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
