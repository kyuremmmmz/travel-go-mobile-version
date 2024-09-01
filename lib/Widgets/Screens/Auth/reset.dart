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
                      height: 500,
                      width: 410,
                      color: Colors.blue,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
