import 'package:flutter/material.dart';

// ignore: camel_case_types
class inputTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;
  final Color? colorr;

  const inputTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.colorr,
  });

  @override
  State<inputTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<inputTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: widget.text,
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          ))),
      focusNode: _focusNode,
      style: TextStyle(
        fontSize: 12,
        color: widget.colorr,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
