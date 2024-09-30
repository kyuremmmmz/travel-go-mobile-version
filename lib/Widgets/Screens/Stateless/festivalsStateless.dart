import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/festivalsList.dart';

class FestivalsStateless extends StatelessWidget {
  const FestivalsStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Festival(),
    );
  }
}
