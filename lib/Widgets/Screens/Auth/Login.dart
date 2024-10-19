import 'package:TravelGo/Controllers/Auth/login.dart'; // Import login logic
import 'package:TravelGo/Routes/Routes.dart'; // Import routes for navigation
import 'package:TravelGo/Widgets/Textfield/passwordField.dart'; // import passowrd widget
import 'package:flutter/material.dart'; // Import thr material design widgets
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

import '../../Textfield/plainTextField.dart'; //Import plain text widget
import './../../Buttons/DefaultButtons/BlueButton.dart'; // Import custom blue button widget

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure proper initialization before running the app
  runApp(const Loginscreen()); // this run the loginscreen widget
}

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key}); // Constructor for Loginscreen

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Travel Go Pangasinan',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Set LoginScreen as the home widget
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // Constructor for LoginScreen

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState(); // Create the state for LoginScreen
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController =
      TextEditingController(); // Controller for the email text field
  final _passwordController =
      TextEditingController(); // Controller for the password text field

  @override
  void dispose() {
    // the dispose of the controllers when the widget is removed from the tree
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState(); // Initialize any state when the widget is first created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // this avoid resizing the body when the keyboard appears
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -85.w,
            right: -30.h,
            left: -30.h,
            child: Stack(
              children: [
              Align(
                child: Image.asset(
                  'assets/images/Background.png',
                  fit: BoxFit.cover, // Cover the whole container with the image
                  height: 470.h,
                  width: 500.w,
                ),
              ),
              Container(
                height: 470.h,
                width: 500.w,
                color: Colors.black.withOpacity(0.5), // Semi-transparent black overlay
              )
            ]),
          ),
          Positioned(
            top: 130.h,
            right: 85.w,
            child: Text(
              textAlign: TextAlign.center,
              'TRAVEL GO', // the logo area
              style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(5.0.w, 5.0.h), // Shadow position
                      blurRadius: 12.0.w,
                      color: Colors.black,
                    )
                  ]),
            ),
          ),
          Positioned(
              top: 185.h,
              right: 50.w,
              child: Text(
                textAlign: TextAlign.center,
                'Travel and get more experience here in Pangasinan!', // the caption area next the trevel go text
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp),
              )),
          Positioned(
            bottom: -320.h,
            right: 0,
            left: 0,
            height: 800.h,
            child: Container(
              padding: EdgeInsets.only(
                top: 0.w,
                left: 0.h,
                bottom: 0.w,
                right: 0.h,
              ),
              decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h, // space between the img and email
                    ),
                    Container(
                      width: 350.w, // the  width of the line 
                      padding: EdgeInsets.only(top: 0.w),
                      child: plainTextField(
                        colorr: Colors.black,
                        text: 'Email',
                        controller: _emailController,
                      ),
                    ),
                    SizedBox(
                      height: 30.h, // Space between the email and password fields
                    ),
                    SizedBox(
                      width: 350.w,
                      child: passwordTextField(
                        text:
                            'Password', // Placeholder text for the password field
                        password:
                            _passwordController, // Controller for the password field
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 25.w, left: 240.w),
                      child: GestureDetector(
                        onTap: () => {
                          AppRoutes.navigateToForgotPassword(context)
                        }, // Navigate to the forgot password screen
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors
                                  .grey), // Style for the forgot password text
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70.h, // Space above the sign-in button
                    ),
                    Container(
                        padding: null,
                        width: 300.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                30), // Rounded corners for the button
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              )
                            ]),
                        child: BlueButtonWithoutFunction(
                          text: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp), // Style for the button text
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 50, 190, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          oppressed: () async {
                            Login(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim())
                                .loginUser(context); // Call the login function
                          },
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}