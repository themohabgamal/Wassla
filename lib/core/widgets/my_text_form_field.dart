import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String labelText;
  final Widget prefixIcon;
  final String? Function(String?) validator;
  final bool obscureText;
  const MyTextFormField(
      {super.key,
      required this.controller,
      this.keyboardType,
      required this.labelText,
      required this.prefixIcon,
      required this.validator,
      required this.obscureText});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
      ),
      validator: widget.validator,
    );
  }
}
