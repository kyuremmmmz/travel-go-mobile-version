import 'package:flutter/material.dart';

// ignore: camel_case_types
class numberTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;
  const numberTextField({
    super.key,
    required this.text,
    this.controller,
  });

  @override
  State<numberTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<numberTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.text,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        labelStyle: const TextStyle(color: Colors.black),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
