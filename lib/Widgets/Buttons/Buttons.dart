// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Buttonns extends StatefulWidget {
  late final String text;
  late final Color initialColor;
  late final String textDisplay;

  Buttonns({
    Key? key,
    required this.text,
    required this.initialColor,
    required this.textDisplay,
  }) : super(key: key);
  @override
  State<Buttonns> createState() => _ButtonnsState();


}

class _ButtonnsState extends State<Buttonns> {
  late Color haha;
  late String buttontext;
  @override
  void initState(){
    super.initState();
    haha = widget.initialColor;
    buttontext = widget.textDisplay;
  }

  void setter() {
    setState(() {
      haha = haha ==  Colors.green ? Colors.red : Colors.green;
      buttontext = haha == Colors.green ? "buttonpressed" : "button";
      print('button pressed');
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellowAccent,
      ),
      onPressed: setter, 
      child: Text(buttontext),
      );
  }
}
