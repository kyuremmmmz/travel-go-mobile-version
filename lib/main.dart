import 'package:flutter/material.dart';

import './Widgets/Buttons/BlueButton.dart';
import './Widgets/Buttons/GreenButton.dart';


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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          Padding(
                padding: const EdgeInsets.only(
                  top: 100
                ),
                child: Container(
                alignment: Alignment.bottomCenter,
                width: 500,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(221, 0, 0, 0),
                  shape: BoxShape.circle
                ),
                child: const Text(
                  'Tite',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Padding( 
              padding: EdgeInsets.only(
                top: 200
              ),
              child: Text(
                'Travel Go Pangasinan',
                textAlign: TextAlign.center,              
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                top: 200
              ),
              child: Column(
                children: <Widget>[
                  Bluebottle(
                    color: Colors.blue, 
                    text: 'Log in'
                  ),
                  const Text(
                    'or'
                  ),
                  Greenbutton(
                    text: 'Create Account', 
                    color: Colors.green
                  )
                ],
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