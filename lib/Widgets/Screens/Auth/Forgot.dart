import 'package:flutter/material.dart';
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

                  Search(
                    controller: _emailController, 
                    style: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: Colors.black
                      ),
                      hintText: "Enter your email",
                      filled: true,
                      fillColor: Colors.white,
                    )
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
