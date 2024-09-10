import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/beaches.dart';

class BeachesStateless extends StatelessWidget {
  const BeachesStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BeachesScreen(),
    );
  }
}
