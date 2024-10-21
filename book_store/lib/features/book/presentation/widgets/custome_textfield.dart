import 'package:flutter/material.dart';

class CustomeTextfield extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final Icon? prefix;
  final IconButton? suffix;
  final bool? obscureText;
  final TextInputType inputType;
  final FormFieldValidator<String>? validator;

  const CustomeTextfield(
      {super.key,
      required this.name,
      required this.inputType,
      this.validator,
      required this.controller,
      this.suffix,
      this.obscureText,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      controller: controller,
      obscureText: obscureText ?? false,
      maxLines: 1,
      keyboardType: inputType,
      validator: validator,
      style: const TextStyle(
          fontFamily: 'Schyler', fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        prefix: prefix,
        suffixIcon: suffix,
        labelText: name,
        labelStyle: const TextStyle(fontFamily: 'Schyler'),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }
}
