import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/Widgets/Textfield/searchField.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 130,
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
                const SizedBox(
                  height: 30,
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                  child: const Text(
                    textAlign: TextAlign.center,
                    "Enter the email associated with your account \n and we'll send an email with instructions \n to reset your password. ",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54
                    ),
                  ),
                )
              ],
            )
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 500,
              width: 410,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),
              child:  Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 350,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.3,
                          blurRadius: 12.0,
                          offset: Offset(0, 6.0)
                        )
                      ]
                    ),
                    child: Search(
                          controller: _emailController,
                          style: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50)
                              ),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50)
                                )
                              ),
                            hintText: "Email Address",
                            filled: true,
                            fillColor: Colors.white,
                          )
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      BlueButtonWithoutFunction(
                        text: const Text('Send Instructions'), 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                        ),
                        oppressed: oppressed)
                    ],
                  ),
                )
              )
            ],
          ),
        );
      }
    }
