// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class Greenbutton extends StatefulWidget {
  late String text;
  late Color color;
  Greenbutton({
    super.key,
    required this.text,
    this.color = const Color(0xFF66BB6A),
  });

  @override
  State<Greenbutton> createState() => _GreenbuttonState();
}

class _GreenbuttonState extends State<Greenbutton> {
  
  // ignore: non_constant_identifier_names
  void RouteTo(String route){
        Navigator.pushNamed(
          context, 
          route
        );
  }
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed:()=>RouteTo('../Screens/Auth/Signup.dart'),
      style: ElevatedButton.styleFrom(
        minimumSize:const Size(300, 40),
        backgroundColor: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      child:  Text(widget.text, 
      style: const TextStyle(
        color: Colors.black
      ),
      ),
    );
  }
}