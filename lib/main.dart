import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel go',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      backgroundColor: const Color.fromARGB(31, 2, 0, 0),
      body: Column(
        children: <Widget>[
          Align(
                alignment: Alignment.center,
                child: Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(50) ,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(221, 0, 0, 0),
                  shape: BoxShape.circle
                ),
              ),
            ),
            const Text('Travel go Pangasinan',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            )
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(const WelcomePage());
}