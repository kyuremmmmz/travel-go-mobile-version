import 'package:flutter/material.dart';

// ignore: camel_case_types
class numberTextField extends StatefulWidget {
  final String? text;

    const numberTextField
    ({
      super.key,
      required this.text,
    });

  @override
  State<numberTextField> createState() => _numberTextFieldState();
}


// ignore: camel_case_types
class _numberTextFieldState extends State<numberTextField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration:  InputDecoration(
          labelText: widget.text,
          border: const UnderlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }
}