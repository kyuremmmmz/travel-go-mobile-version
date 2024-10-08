import 'package:flutter/material.dart';
import 'package:TravelGo/Widgets/Screens/App/hotels.dart';

class HotelStateless extends StatelessWidget {
  const HotelStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HotelScreen(),
    );
  }
}