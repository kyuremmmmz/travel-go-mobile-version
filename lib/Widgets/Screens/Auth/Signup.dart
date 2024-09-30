import 'package:flutter/material.dart';
import 'package:itransit/Controllers/Auth/signup.dart';
import 'package:itransit/Widgets/Textfield/passwordField.dart';

import '../../Textfield/plainTextField.dart';
import './../../Buttons/DefaultButtons/BlueButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SignUpscreen());
}

class SignUpscreen extends StatelessWidget {
  const SignUpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Travel Go Pangasinan',
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  final BuildContext? context;
  final String? email;
  const SignUpScreen({super.key, this.context, this.email});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -85.w,
            right: -30.h,
            left: -30.h,
            child: Stack(children: [
              Align(
                child: Image.asset(
                  'assets/images/Background.png',
                  fit: BoxFit.cover,
                  height: 470.h,
                  width: 500.w,
                ),
              ),
              Container(
                height: 470.h,
                width: 500.w,
                color: Colors.black.withOpacity(0.5),
              )
            ]),
          ),
          Positioned(
            top: 130.h,
            right: 85.w,
            child: Text(
              textAlign: TextAlign.center,
              'TRAVEL GO',
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
                'Travel and get more experience here in Pangasinan!',
                textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp)
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
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      width: 350.w, // email line area
                      padding: EdgeInsets.only(top: 0.w),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email address';
                          }

                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'please enter valid email address';
                          }
                          signUp.sign(context, value);
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
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      width: 350.w, // full name line area
                      padding: EdgeInsets.only(top: 0.w),
                      child: plainTextField(
                        colorr: Colors.black,
                        text: 'Full name',
                        controller: _nameController,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      width: 350.w, // password line area
                      child: passwordTextField(
                        text: 'Password',
                        password: _passwordController,
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Container(
                        padding: null,
                        width: 300.w,
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
                            style: TextStyle(color: Colors.white, fontSize: 18.sp),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 50, 190, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          oppressed: () async {
                            await Signup(
                                    email: _emailController.text.trim(),
                                    fullName: _nameController.text.trim(),
                                    password: _passwordController.text.trim())
                                .sign(context, _emailController.text);
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