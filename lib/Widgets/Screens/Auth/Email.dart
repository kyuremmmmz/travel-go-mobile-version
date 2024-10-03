import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itransit/Routes/Routes.dart';
import './../../Buttons/DefaultButtons/BlueButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({super.key});

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 80.w,
              right: 10.h,
              left: 10.h,
              child: Column(
                children: [
                  SizedBox(
                    width: 150.w,
                    height: 180.h,
                    child: Image.asset('assets/images/GmailLogo.png'),
                  ),
                  Container(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Take a look at your email.',
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                ],
              )),
          Positioned(
              bottom: -150.w,
              height:630.h, // the height of the blue contianer
              child: Container(
                  height: 500.h,
                  width: 373.w,
                  decoration: BoxDecoration(
                      color: Color(0xFF44CAF9),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.w),
                          topRight: Radius.circular(50.w))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'We have sent a password recover \nInstructions to your email.',
                        style: TextStyle(fontSize: 16.sp, 
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                      ),
                      SizedBox(
                        height: 25.h // the space between the caption and next
                      ),
                      Container(
                        height: 35.h,
                        width: 160.w, // Set your desired width here
                      child:  BlueButtonWithoutFunction(
                        text: Text(
                          'Next',
                          style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        oppressed: () => AppRoutes.navigateToResetScreen(
                            context), // Add route later or change
                      ),
                      ),
                      SizedBox(
                        height: 15.h, // the space between the next and skip
                      ),
                      GestureDetector(
                        onTap: () => print(
                            "Confirm Detected"), // Add route for skipping confirmation or change
                        child: Text(
                          'Skip I\'ll confirm later',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Color(0xFF534D4D)),
                        ),
                      ),
                      SizedBox(
                        height: 225.h,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                              text:
                                  "Did not receive the email? Check your spam \nfilter or ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "try another email address.",
                              style: const TextStyle(color: Colors.white),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => AppRoutes.navigateToForgotPassword(
                                    context) // Add Route for trying email address or change
                              )
                        ]),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
