import 'package:flutter/material.dart';
import '../App/exploreNow.dart';

// ignore: camel_case_types
class explore extends StatelessWidget {
  const explore({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: Explorenow()
    );
  }
}
