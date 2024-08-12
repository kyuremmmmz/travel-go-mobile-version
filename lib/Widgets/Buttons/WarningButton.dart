import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RedButton extends StatefulWidget {
  final String text;
  late Color color;

    RedButton({
    super.key, 
    required this.text, 
    required this.color
   });

  @override
  State<RedButton> createState() => _RedButtonState();
}

class _RedButtonState extends State<RedButton> {
   function(String value)=>{
        // ignore: avoid_print
        print(value)
  };
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: function('button pressed'),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color=Colors.red,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        widget.text,
      ),
    );
  }
}