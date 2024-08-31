import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './../../Buttons/DefaultButtons/BlueButton.dart';

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({super.key});

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 130,
            right: 50,
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 200,
                  child: Image.asset('assets/images/GmailLogo.png'),
                ),
                Container(
                  child: const  Text(
                  textAlign: TextAlign.center,
                  'Check your email',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 480,
              width: 410,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'We have sent a password recover \nInstructions to your email.',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                      ),
                  ),

                const SizedBox(
                  height: 30,
                ),
                BlueButtonWithoutFunction(
                          text: const Text(
                            'Open Email App',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          oppressed: ()=> "", // Add route later or change
                        ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                        onTap: () => print("Confirm Detected"), // Add route for skipping confirmation or change
                        child: const Text(
                          'Skip I\'ll confirm later',
                          style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 216, 216, 216)),
                        ),
                      ),
                const SizedBox(
                  height: 190,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(text: "Did not receive the email? Check your spam \nfilter or ", style: TextStyle(color: Colors.black)),
                    TextSpan(text: "try another email address.", style: TextStyle(color: Colors.white),
                    recognizer: TapGestureRecognizer() ..onTap = ()=> print("Test") // Add Route for trying email address or change
                    )
                  ]
                ),
                ),
            ],)
            )
          )
        ],
      ),
    );
  }
}
