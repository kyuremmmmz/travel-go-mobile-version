import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/Widgets/Screens/Stateless/email.dart';
import 'package:itransit/Widgets/Textfield/passwordField.dart';
import 'package:itransit/Widgets/Textfield/number.dart';
import 'package:itransit/Widgets/Textfield/plainTextField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              right: 80,
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    child: const Text(
                      'Create New Password',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: const Text(
                        textAlign: TextAlign.justify,
                        'Your new password must be different from \nprevious used passwords.'),
                  )
                ],
              )),
          Positioned(
              bottom: 0,
              left: -1,
              right: -1,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 550,
                      width: 410,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: 390,
                            child: const numberTextField(text: 'Reset Token'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 390,
                            child: plainTextField(
                              colorr: Colors.black,
                              text: 'Email',
                              controller: _emailController,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 390,
                            child: passwordTextField(
                              text: 'Password',
                              password: _passwordController,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: 300,
                            child: BlueButtonWithoutFunction(
                                text: const Text(
                                  'Reset Password',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                oppressed: () => print('test')),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
