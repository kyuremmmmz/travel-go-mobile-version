// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: camel_case_types
class PhonenumberTextField extends StatefulWidget {
  final String? text;

    const PhonenumberTextField
    ({
      super.key,
      required this.text,
    });

  @override
  State<PhonenumberTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<PhonenumberTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration:  InputDecoration(
          labelText: widget.text,
          border: const UnderlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      style: const TextStyle(
        fontSize: 12
      ),
    );
  }
}
