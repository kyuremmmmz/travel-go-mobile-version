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
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration:  InputDecoration(
          labelText: widget.text,
          border: const UnderlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}