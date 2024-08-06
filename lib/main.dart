import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('I transition'),
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.black54,
            border:
            Border.all(
              color: Colors.black45,
              width: 500,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Text(
              'Hello world',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
