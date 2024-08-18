import 'package:flutter/material.dart';

class BlueButtonWithoutFunction extends StatefulWidget {
  late String text;
  late Color color;
   BlueButtonWithoutFunction
  ({
    super.key,
    required this.text,
    required this.color,


  });

  @override
  State<BlueButtonWithoutFunction> createState() => _BlueButtonWithoutFunctionState();
}

class _BlueButtonWithoutFunctionState extends State<BlueButtonWithoutFunction> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: ()=> print('Hello!') ,
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