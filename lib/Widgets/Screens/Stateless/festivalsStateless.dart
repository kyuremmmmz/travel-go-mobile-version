import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/festivalsList.dart';

class Festivalsstateless extends StatelessWidget {
  const Festivalsstateless({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Festival(),
    );
  }
}
