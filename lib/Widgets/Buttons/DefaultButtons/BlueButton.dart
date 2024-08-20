import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlueButtonWithoutFunction extends StatefulWidget {
  late String text;
  late ButtonStyle style;
  late VoidCallback oppressed;
   BlueButtonWithoutFunction
  ({
    super.key,
    required this.text,
    required this.style,
    required this.oppressed,
  });

  @override
  State<BlueButtonWithoutFunction> createState() => _BlueButtonWithoutFunctionState();
}

class _BlueButtonWithoutFunctionState extends State<BlueButtonWithoutFunction> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: widget.oppressed,
      style: widget.style,
      child: Text
      (
        widget.text, 
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}