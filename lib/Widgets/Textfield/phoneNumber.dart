// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: camel_case_types
class PhonenumberTextField extends StatefulWidget {
  final String? text;
  final TextEditingController controller;
  final Icon? icon;
  const PhonenumberTextField({
    super.key,
    required this.text,
    required this.controller,
    this.icon,
  });

  @override
  State<PhonenumberTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<PhonenumberTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: widget.icon,
          labelText: widget.text,
          labelStyle: const TextStyle(
            fontSize: 12,
          ),
          floatingLabelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
          ))),
      keyboardType: TextInputType.phone,
      style: const TextStyle(fontSize: 12),
    );
  }
}
