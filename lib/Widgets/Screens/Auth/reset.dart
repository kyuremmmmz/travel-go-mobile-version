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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              right: 20.w,
              left: -20.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                    width: 80.w,
                  ),
                  Container(
                    padding: null,
                    child: Text(
                      'Create New Password',
                      style:
                          TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: null,
                    child: Text(
                        textAlign: TextAlign.justify,
                        'Your new password must be different from \nprevious used passwords.',
                        style: 
                            TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),),
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
                      height: 550.h,
                      width: 410.w,
                      decoration: const BoxDecoration(
                          color: Color(0xFF44CAF9),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                            padding: null,
                            width: 350.w, // the width of the line 
                            child: numberTextField(
                              text: 'Reset Token',
                              controller: _resetTokenController,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            padding: null,
                            width: 350.w,
                            child: plainTextField(
                              colorr: Colors.black,
                              text: 'Email',
                              controller: _emailController,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            padding: null,
                            width: 350.w,
                            child: passwordTextField(
                              text: 'Password',
                              password: _passwordController,
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                            padding: null,
                            width: 170.w,
                            height: 45.h,
                            child: BlueButtonWithoutFunction(
                                text: Text(
                                  'Reset Password',
                                  style: TextStyle(color: Colors.black, fontSize: 15.sp,),
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