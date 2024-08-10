import 'package:flutter/material.dart';

class Buttonns extends StatefulWidget {
  late final String text;
  late final Color initialColor;

  Buttonns({required this.text, this.initialColor = Colors.green});
  @override
  State<Buttonns> createState() => _ButtonnsState();


}

class _ButtonnsState extends State<Buttonns> {
  late Color haha;
  @override
  void initState(){
    super.initState();
    haha = widget.initialColor;
  }

  void setter() {
    setState(() {
      haha = haha ==  Colors.green ? Colors.red : Colors.green;
      print('button pressed');
    });
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: setter, 
      child: Text(widget.text)
      );
  }
}
