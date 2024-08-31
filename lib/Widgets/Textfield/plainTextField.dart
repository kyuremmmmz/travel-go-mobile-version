import 'package:flutter/material.dart';

// ignore: camel_case_types
class plainTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? controller;

  const plainTextField({
    super.key,
    required this.text,
    required this.controller,
  });

  @override
  State<plainTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<plainTextField> {
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
          labelText: widget.text,
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          labelStyle: const TextStyle(
            fontSize: 15,
          ),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
          )
        )
      ),
      focusNode: _focusNode,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
