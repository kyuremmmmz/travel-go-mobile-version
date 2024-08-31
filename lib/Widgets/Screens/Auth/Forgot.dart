import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 150,
            right: 50,
            child: Column(
              children: [
                Container(
                  child: const  Text(
                  textAlign: TextAlign.center,
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  ),
                ),
                Container(
                  child: const Text(
                    textAlign: TextAlign.center,
                    "Enter the email associated with your account \n and we'll send an email with instructions \n to reset your password. ",
                    style: TextStyle(
                      fontSize: 13
                    ),
                  ),
                )
              ],
            )
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 400,
              width: 410,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),
            )
          )
        ],
      ),
    );
  }
}
