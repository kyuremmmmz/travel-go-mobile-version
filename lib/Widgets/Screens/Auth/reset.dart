import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/Widgets/Textfield/passwordField.dart';
import 'package:itransit/Widgets/Textfield/number.dart';
import 'package:itransit/Widgets/Textfield/plainTextField.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _resetTokenController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _resetTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              right: 80.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 350.h,
                    width: -560.w,
                  ),
                  Container(
                    padding: null,
                    child: Text(
                      'Create New Password',
                      style:
                          TextStyle(fontSize: 30.sp, 
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: null,
                    child: Text(
                        'Your new password must be different from \nprevious used passwords.', 
                        textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 16.0.sp,)
                        
                        ),
                  )
                ],
              )),
          Positioned(
              bottom: 0,
              left: -1,
              right: -1,
              child: Container(
                padding: null,
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
                            padding: null,
                            width: 390,
                            child: numberTextField(
                              text: 'Reset Token',
                              controller: _resetTokenController,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: null,
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
                            padding: null,
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
                            padding: null,
                            width: 300,
                            child: BlueButtonWithoutFunction(
                                text: const Text(
                                  'Reset Password',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                oppressed: () => Usersss().resetPasssword(
                                    _resetTokenController.text.trim(),
                                    _emailController.text.trim(),
                                    _passwordController.text.trim())),
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
