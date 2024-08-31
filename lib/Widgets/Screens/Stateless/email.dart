import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/Auth/Email.dart';
// ignore: camel_case_types
class email extends StatelessWidget {
  const email({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CheckEmailScreen(),
    );
  }
}