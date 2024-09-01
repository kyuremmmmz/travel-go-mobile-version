import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              right: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                      child: RichText(
                          text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Create New Password',
                        style: TextStyle(color: Colors.black, fontSize: 30))
                  ]))),
                ],
              ))
        ],
      ),
    );
  }
}
