import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children: <Widget>[
        Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(221, 51, 51, 51),
                  shape: BoxShape.circle
                ),
                child: const Text(
                  'Travel Go Pangasinan',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }
}


void main() {
  runApp(const WelcomePage());
}