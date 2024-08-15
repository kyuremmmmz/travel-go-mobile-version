// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import './../../Screens/Auth/Login.dart';
//import '../Auth/Login.dart';
class Bluebottle extends StatefulWidget {
  late Color color;
  late String text;
  Bluebottle({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  State<Bluebottle> createState() => _BluebottleState();

}

class _BluebottleState extends State<Bluebottle> {
  
  //Reminder: ito is dapat practice na may setters here
  void setter(Widget routeName){
      Navigator.push(context,
      MaterialPageRoute(builder: 
      (context) => routeName,
    ));
  }

  
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=>setter(const LoginScreen()),
      style: ElevatedButton.styleFrom(
        minimumSize:const Size(300, 40),
        backgroundColor: widget.color = Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    );
  }
}