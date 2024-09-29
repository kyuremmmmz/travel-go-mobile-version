import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/foodArea_list.dart';

class FoodAreastateless extends StatelessWidget {
  const FoodAreastateless({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FoodArea(),
    );
  }
}