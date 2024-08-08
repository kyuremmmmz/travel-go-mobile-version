import 'package:flutter/material.dart';

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
      ),
    );
  }
}
