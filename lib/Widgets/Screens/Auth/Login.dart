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
  final _formKey = GlobalKey<FormState>();

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
      backgroundColor: const Color(0xFFDEEFFC),
      resizeToAvoidBottomInset:
          false, // this avoid resizing the body when the keyboard appears
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0.h,
            right: 0.w,
            left: 0.w,
            child: Stack(children: <Widget>[
              Align(
                child: Image.asset(
                  'assets/images/icon/newlogo.png',
                  fit: BoxFit.cover,
                  height: 200.h,
                  width: 200.w,
                ),
              ),
              Positioned(
                top: 100,
                bottom: 50, // Adjust the position of the second image
                right: 0,
                left: 0, // Change as needed
                child: Image.asset(
                  'assets/images/icon/airplanelogo.png', // Replace with your image path
                ),
              ),
              SizedBox(
                height: 470.h, // Adjust the image size
              )
            ]),
          ),
          Positioned(
              bottom: -330.h,
              right: 0,
              left: 0,
              height: MediaQuery.of(context).size.height,
              child: Container(
                padding: EdgeInsets.only(
                  top: 0.h,
                  left: 0.w,
                  bottom: 0.h,
                  right: 0.w,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 90.w, bottom: 0.w, top: 60.w),
                          child: Text(
                            'Welcome Traveler!',
                            style: TextStyle(
                              color: const Color(0xFF2D3F4E),
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(right: 170.w, top: 0.w, bottom: 30.w),
                            child: const Text(
                              'Please Sign In to continue.',
                              style: TextStyle(
                                color: Color(0xFF3564C0),
                              ),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width - 30.w,
                          child: plainTextField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email address is required';
                              }
                              return null;
                            },
                            colorr: Colors.black,
                            text: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 10
                              .h, // Space between the email and password fields
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30.w,
                          child: passwordTextField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            text:
                                'Password', // Placeholder text for the password field
                            password:
                                _passwordController, // Controller for the password field
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.h, left: 240.w),
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
                            width: MediaQuery.of(context).size.width - 100.w,
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
                                'Log In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        18.sp), // Style for the button text
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 50, 190, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              oppressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Login(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim())
                                      .loginUser(
                                          context); // Call the login function
                                }
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}