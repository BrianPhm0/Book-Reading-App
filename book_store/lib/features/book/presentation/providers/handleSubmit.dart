import 'package:flutter/material.dart';

class FormHandler {
  //create global key
  final GlobalKey<FormState> formKey;
  //create list of controller
  final List<TextEditingController> controllers;
  //validation
  final List<FormFieldValidator<String>?> validators;

  FormHandler({
    required this.formKey,
    required this.controllers,
    required this.validators,
  });

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void submit(VoidCallback onSuccess) {
    if (validate()) {
      onSuccess();
    }
  }

  //getform data
  Map<String, String> getFormData() {
    final data = <String, String>{};
    for (var controller in controllers) {
      data[controller.text] = controller.text;
    }
    return data;
  }
}
