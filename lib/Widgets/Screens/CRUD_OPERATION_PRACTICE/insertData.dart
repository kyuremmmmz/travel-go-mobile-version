import 'package:flutter/material.dart';

class Insertdata extends StatefulWidget {
  const Insertdata({super.key});

  @override
  State<Insertdata> createState() => _InsertdataState();
}

class _InsertdataState extends State<Insertdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Insert data'),
      ),
    );
  }
}