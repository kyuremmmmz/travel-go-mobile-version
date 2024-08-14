import 'package:flutter/material.dart';

// ignore: camel_case_types, must_be_immutable
class numbers extends StatefulWidget {
  late String text;
  numbers
    ({
      super.key,
      required this.text
    });

  @override
  State<numbers> createState() => _numbersState();
}

// ignore: camel_case_types
class _numbersState extends State<numbers> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
      border: const UnderlineInputBorder(),
      labelText: widget.text,
      ),
    );
  }
}