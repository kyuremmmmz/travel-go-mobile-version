import 'package:flutter/material.dart';

class Notpaid extends StatefulWidget {
  const Notpaid({super.key});

  @override
  State<Notpaid> createState() => _NotpaidState();
}

class _NotpaidState extends State<Notpaid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
      ),
      body: const Center(
        child:  Text(' Not Paid yet '),
      ),
    );
  }
}
