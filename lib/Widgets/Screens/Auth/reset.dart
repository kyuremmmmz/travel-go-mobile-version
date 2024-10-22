import 'package:flutter/material.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Textfield/passwordField.dart';
import 'package:TravelGo/Widgets/Textfield/number.dart';
import 'package:TravelGo/Widgets/Textfield/plainTextField.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
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
    backgroundColor: const Color(0xFFDEEFFC),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              right: 20.w,
              left: -20.w,
              top: 60.h,
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
                    padding: EdgeInsets.only(top: 20.h),
                    child: Text(
                        textAlign: TextAlign.justify,
                        'Your new password must be different from \nprevious used passwords.',
                        style: 
                            TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),),
                  )
                ],
              )),
          Positioned(
              bottom: -20,
              left: -1,
              right: -1,
              child: Container(
                padding: null,
                child: Column(
                  children: [
                    SizedBox(
                      height: 550.h,
                      width: 410.w,
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
                              text: 'New Password', // Password
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
                                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 15.sp,),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF44CAF9),
                                        shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0), // Adjust the radius as needed
                                    ),
                                  ),
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