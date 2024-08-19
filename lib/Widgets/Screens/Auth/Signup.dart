/*
import 'package:flutter/material.dart';

import '../../Textfield/phoneNumber.dart';
import '../../Textfield/plainTextField.dart';
import './../../Textfield/passwordField.dart';


void main(){
  runApp(const signupScreen());
}
 @override
Widget build(BuildContext context) {
  return const MaterialApp(
    home: signupScreen(),
  );
}
// ignore: camel_case_types
class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupState();
}

// ignore: camel_case_types
class _signupState extends State<signupScreen> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Sign up',
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                ),
                child:  Column(
                  children: <Widget>[
                    plainTextField
                    ( text: 'Enter your name...', 
                      controller: _controller,
                    ),
                    const SizedBox(height: 10),
                    const passwordTextField(text: 'Enter your password...'),
                    const SizedBox(height: 10),
                    const PhonenumberTextField(text: 'Enter your phone number...'),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    */