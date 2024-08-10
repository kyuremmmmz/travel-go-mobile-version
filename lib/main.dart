import 'package:flutter/material.dart';

import 'Widgets/Buttons/Buttons.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'i transit',
      home: Scaffold( 
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Buttonns(
            text: 'Click me baby' ,
            initialColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}
