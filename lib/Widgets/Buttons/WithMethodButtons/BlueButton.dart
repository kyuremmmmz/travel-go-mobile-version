// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import './../../../Routes/Routes.dart';

//import '../Auth/Login.dart';
class Bluebottle extends StatefulWidget {
  late ButtonStyle color;
  late Text text;
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

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => AppRoutes.navigateToLogin(context),
      style: widget.color,
      child: widget.text,
    );
  }
}
