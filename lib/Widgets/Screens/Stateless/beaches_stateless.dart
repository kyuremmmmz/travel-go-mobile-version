import 'package:flutter/material.dart';
import 'package:TravelGo/Widgets/Screens/App/beachList.dart';

class BeachesStateless extends StatelessWidget {
  const BeachesStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Beaches(),
    );
  }
}
