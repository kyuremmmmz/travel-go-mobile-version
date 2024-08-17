import 'package:flutter/material.dart';

// ignore: camel_case_types
class passwordTextField extends StatefulWidget {
  final String? text;

    const passwordTextField
    ({
      super.key,
      required this.text,
    });

  @override
  State<passwordTextField> createState() => _numberTextFieldState();
}


// ignore: camel_case_types
class _numberTextFieldState extends State<passwordTextField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration:  InputDecoration(
          labelText: widget.text,
          border: const UnderlineInputBorder(),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}