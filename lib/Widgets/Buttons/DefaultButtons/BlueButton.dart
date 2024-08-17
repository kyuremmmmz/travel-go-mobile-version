import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GreenButtonWithoutMethod extends StatefulWidget {
  late String text;
  late Color color;
  GreenButtonWithoutMethod
  ({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  State<GreenButtonWithoutMethod> createState() => _GreenButtonWithoutMethodState();
}

class _GreenButtonWithoutMethodState extends State<GreenButtonWithoutMethod> {
  void funct(){
    print('hello christian');
  }
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(30),
        )
      ),
      onPressed: ()=>funct(),
      child:  Text(
        widget.text,
      ),
    );
  }
}