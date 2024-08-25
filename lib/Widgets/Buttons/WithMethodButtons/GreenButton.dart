// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import './../../../Routes/Routes.dart';
class Greenbutton extends StatefulWidget {
  late String text;
  late ButtonStyle color;
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
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: ()
      {
        AppRoutes.navigateTosignUp(context);
      },
      style: widget.color,
      child:  Text(widget.text, 
      style: const TextStyle(
        color: Colors.black
        ),
      ),
    );
  }
}