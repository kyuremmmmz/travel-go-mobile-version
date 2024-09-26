import 'package:flutter/material.dart';

// ignore: camel_case_types
class plainTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;
  final Color? colorr;

  const plainTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.colorr,
  });

  @override
  State<plainTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<plainTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: widget.text,
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          labelStyle: const TextStyle(
          fontSize: 15, color: Colors.black),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black
                )
              ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
          )
          )
        ),
      style: TextStyle(
        fontSize: 12,
        color: widget.colorr,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}