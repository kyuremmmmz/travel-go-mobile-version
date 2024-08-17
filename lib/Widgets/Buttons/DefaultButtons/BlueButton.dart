import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlueButtonWithoutMethod extends StatefulWidget {
  late String text;
  late Color color;
  BlueButtonWithoutMethod
    ({
      super.key,
      required this.text,
      required this.color,
    });
    

  @override
  State<BlueButtonWithoutMethod> createState() => _BlueButtonWithoutMethodState();
}

class _BlueButtonWithoutMethodState extends State<BlueButtonWithoutMethod> {
  void func(){
      print('Click me');
    }
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 30),
        backgroundColor: widget.color,
      ),
      onPressed: ()=>func(),//Lambda Expression
      child: Text(
        widget.text
      ),
    );
  }
}