import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? inputText;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void _showInputDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter some text'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Input',
                  hintText: 'Type something here',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  inputText = value;
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save(); // Save the input
                    Navigator.of(context).pop(); // Close dialog after submit
                    _showResultDialog(); // Show result after closing
                  }
                },
              ),
            ],
          );
        });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Submitted Text'),
          content: Text('You entered: $inputText'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the result dialog
              },
            ),
          ],
        );
      },
    );
  }
}
