// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
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
  void setter(String routeName){
      Navigator.push(context, routeName as Route<Object?>);
  }

  
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=>setter('../Auth/Login.dart') ,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color = Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 40,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pacifico',
        ),
      ),
    );
  }
}