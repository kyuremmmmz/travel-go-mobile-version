import 'package:flutter/material.dart';

// ignore: camel_case_types
class plainTextField extends StatefulWidget {
  final String? text;

    const plainTextField
    ({
      super.key,
      required this.text,
    });

  @override
  State<plainTextField> createState() => _numberTextFieldState();
}


// ignore: camel_case_types
class _numberTextFieldState extends State<plainTextField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration:  InputDecoration(
          labelText: widget.text,
          border: const UnderlineInputBorder(),
      ),
    );
  }
}