// dialog_utils.dart
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showDialogAuth(
    BuildContext context, String? name, String? title, String? content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        // TextCustom('We sent you a confirmation email',),
        title: const TextCustom(
            text: 'We sent you a confirmation email',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        content: const TextCustom(
            text:
                'An email has been sent to the address associated with your account. Please click the link in the email to reset your password.',
            fontSize: 20,
            color: Colors.black),
        actions: [
          TextButton(
              onPressed: () {
                if (name != null && name.isNotEmpty) {
                  context.goNamed(name);
                }
                Navigator.of(context).pop();
              },
              child: const TextCustom(
                  text: "Done", fontSize: 25, color: Colors.blue)),
        ],
      );
    },
  );
}
