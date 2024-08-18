import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Textfield/passwordField.dart';

import '../../Textfield/plainTextField.dart';
void main(){
  runApp(const LoginScreen());
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 30
            ),
            child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 359,
                  minHeight: 100,
                  minWidth: 200
                ),
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      150
                    )
                  ),
                  color: Colors.blue,
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 80,
                  ),
                  margin: const EdgeInsets.only(
                    left: 20
                  ),
                  child: const Text(
                  'TRAVEL AND GET MORE EXPERIENCE IN BALUNGAO PANGASINAN!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 0
            ),
            child: const Column(
                children: [
                  
                  plainTextField(
                    text: 'Enter your email address'
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  passwordTextField(
                    text: 'Enter your password'
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 20,
            ),
          )
        ],
      ),
    )
  );
}
}
