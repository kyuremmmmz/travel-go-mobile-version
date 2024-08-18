import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/Auth/Login.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Sign up',
            ),
          ),
          body: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 100,
                ),
                child:  Column(
                  children: <Widget>[
                    plainTextField(text: 'Enter your name...'),
                    SizedBox(height: 10),
                    passwordTextField(text: 'Enter your password...'),
                    SizedBox(height: 10),
                    PhonenumberTextField(text: 'Enter your phone number...'),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }