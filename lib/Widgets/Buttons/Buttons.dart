import 'package:flutter/material.dart';

class Buttonns extends StatefulWidget {
  late final String text;
  late final Color initialColor;
  late final String textDisplay;

  Buttonns({required this.text, this.initialColor = Colors.green, required this.textDisplay});
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
      child: Text(widget.text)
      );
  }
}
