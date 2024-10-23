// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/Auth/signup.dart';
import 'package:TravelGo/Widgets/Textfield/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness
import './../../Buttons/DefaultButtons/BlueButton.dart';

class SignUpscreen extends StatelessWidget {
  late final String? fullName;
  late final int? phoneNumber;
  late final String? email;
  late final String? password;
  late final Text error;
  late final String? userName;
  SignUpscreen(
      {super.key,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.password,
      required this.error,
      this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SignUpScreen(
        error: error,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        context: context,
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  final BuildContext? context;
  late final String? fullName;
  late final int? phoneNumber;
  late final String? email;
  late final String? password;
  late final Text error;
  late final String? userName;
  SignUpScreen({
    super.key,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.password,
    required this.error,
    this.context,
    this.userName,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final signUp = Signup();
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void validator(BuildContext context, String email) {
    signUp.sign(context, email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEEFFC),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0.h,
            right: 0,
            left: 0,
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
                height: 400.h, // Adjust the size
              )
            ]),
          ),
          Positioned(
            bottom: -270.h,
            right: 0,
            left: 0,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: EdgeInsets.only(
                top: 0.w,
                left: 0.h,
                bottom: 0.w,
                right: 0.h,
              ),
              child: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 80.w),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: const Color(0xFF2D3F4E),
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 150.w),
                        child: const Text(
                          'Please Sign Up to continue.',
                          style: TextStyle(
                            color: Color(0xFF3564C0),
                          ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 30.w,
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email address is required';
                          }

                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter valid email address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            alignLabelWithHint: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.0),
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          30.w, // password line area
                      child: passwordTextField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length <= 5) {
                            return 'Password must be atleast 6 characters';
                          }
                          return null;
                        },
                        text: 'Password',
                        password: _passwordController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          30.w, // password line area
                      child: passwordTextField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Confirm Password is required';
                          }
                          if (value.length <= 5) {
                            return 'Password must be atleast 6 characters';
                          }
                          if (value != _passwordController.text) {
                            return "Password doesn't match";
                          } else {
                            return null;
                          }
                        },
                        text: 'Confirm Password',
                        password: _confirmPasswordController,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                        padding: null,
                        width: MediaQuery.of(context).size.width - 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
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
                            'Sign Up',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.sp),
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
                              await Signup(
                                      email: _emailController.text.trim(),
                                      fullName: widget.fullName,
                                      password: _confirmPasswordController.text
                                          .trim(),
                                      phoneNumber: widget.phoneNumber,
                                      username: widget.userName)
                                  .sign(
                                context,
                                _emailController.text,
                              );
                            }
                            print(widget.fullName);
                            print(widget.phoneNumber);
                            print(widget.userName);
                          },
                        ))
                  ],
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}