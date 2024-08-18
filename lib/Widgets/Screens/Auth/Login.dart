import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Textfield/passwordField.dart';

import '../../Textfield/plainTextField.dart';
import './../../Buttons/DefaultButtons/BlueButton.dart';
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
                height: 220,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      130
                    )
                  ),
                  color: Colors.blue,
                  
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 80,
                  ),
                  margin: const EdgeInsets.only(
                    left: 30
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
              top: 30
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
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            width: 400,
            child: BlueButtonWithoutFunction(
              text: 'PROCEED', 
              color: const Color.fromARGB(255, 61, 62, 63)
              ),
          )
        ],
      ),
    )
  );
}
}
