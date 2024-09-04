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
          filled: true,
          fillColor: Colors.white,
          labelText: widget.text,
          alignLabelWithHint: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          labelStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
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
