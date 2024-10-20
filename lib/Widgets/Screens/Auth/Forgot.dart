import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Textfield/searchField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color(0xFFDEEFFC),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 130.h,
              right: 50.w, // the center  of the forgot password tezt
              child: Column(
                children: [
                  Container(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 30.h, // the space between the forgot password and this text 
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Enter the email associated with your account \n and we'll send an email with instructions \n to reset your password. ",
                      style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                    ),
                  )
                ],
              )),
          Positioned(
              bottom: 0.w,
              child: Container(
                height: 500.h,
                width: 375.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                      width: 90.w,
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: 330.w, // width of the container of email address 
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.w)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 5))
                          ]),
                      child: Search(
                        controller: _emailController,
                        style: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.h)), // Keep border radius
                            borderSide: BorderSide.none,  // Remove the border line
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.h)), // Keep border radius
                            borderSide: BorderSide.none,  // Remove the border line when focused
                          ),
                          hintText: "Email Address",
                          hintStyle: TextStyle(
                            fontSize: 15.sp,  // Adjust font size
                            color: Colors.black54,  // Set hint text color
                          ),
                          filled: true,
                          fillColor: Colors.white,  // Background color for the input field
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h, // the send instructions space top
                    ),
                    Container(
                      height: 45.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.w)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2.w),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0.h, 5.w))
                          ]),
                      child: BlueButtonWithoutFunction(
                          text: Text(
                            'Send Instructions',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF44CAF9), 
                      ),
                          oppressed: () => Usersss().sendVerificationCode(
                              _emailController.text.trim(), context)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          AppRoutes.navigateToLogin(context);
                        },
                        child: Container(
                          child: Text(
                            'Back to Log In',
                            style: TextStyle(
                              fontSize: 12.sp,
                                color: Color.fromARGB(255, 82, 79, 79)),
                          ),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}