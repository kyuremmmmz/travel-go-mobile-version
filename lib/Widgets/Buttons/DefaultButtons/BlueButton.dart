import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlueButtonWithoutFunction extends StatefulWidget {
  late String text;
  late Color color;
  late Function onpress;
   BlueButtonWithoutFunction
  ({
    super.key,
    required this.text,
    required this.color,
    required this.onpress,


  });

  @override
  State<BlueButtonWithoutFunction> createState() => _BlueButtonWithoutFunctionState();
}

class _BlueButtonWithoutFunctionState extends State<BlueButtonWithoutFunction> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: ()=> widget.onpress ,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: widget.color,
      ),
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