// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';


class Greenbutton extends StatefulWidget {
  late String text;
  late Color color;
  Greenbutton({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  State<Greenbutton> createState() => _GreenbuttonState();
}

class _GreenbuttonState extends State<Greenbutton> {
  
  // ignore: non_constant_identifier_names
  void RouteTo(String route){
        Navigator.push(
          context, 
          route as Route<Object?>
        );
  }
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed:()=>RouteTo('./../Auth/Signup.dart'),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color = Colors.greenAccent[400]!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      child:  Text(widget.text),
    );
  }
}