// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/Auth/signup.dart';
import 'package:TravelGo/Routes/Routes.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Align(
                    child: Image.asset('assets/images/icon/newlogo2.png',
                        fit: BoxFit.cover, height: 200.h, width: 200.w,)),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20.w),
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
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 30.w),
                        child: Text(
                          'Please Sign Up to continue.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF3564C0),
                          ),
                        )),
                    SizedBox(height: 15.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        decoration: InputDecoration(
                            labelText: 'Email',
                            alignLabelWithHint: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.w),
                            labelStyle:
                                TextStyle(fontSize: 15.sp, color: Colors.black),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w), // password line area
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
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w), // password line area
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
                    SizedBox(height: 50.h),
                    Container(
                        width: 250.w,
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
                              showAdaptiveDialog(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        title: Text('Create Account',
                                            style: TextStyle(fontSize: 20.sp)),
                                        content: SingleChildScrollView(
                                            child: ListBody(children: <Widget>[
                                          Text(
                                              'Signed Up successfully! \nCheck your email for confirmation.\n',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                          Text('Full name: ${widget.fullName}',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                          Text('User name: ${widget.userName}',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                          Text(
                                              'Phone Number: ${widget.phoneNumber}',
                                              style:
                                                  TextStyle(fontSize: 12.sp)),
                                          Text(
                                              'Email: ${_emailController.text}',
                                              style: TextStyle(fontSize: 12.sp))
                                        ])),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Back to Main',
                                                style:
                                                    TextStyle(fontSize: 16.sp)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              AppRoutes.navigateToWelcomePage(
                                                  context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                  });
                            }
                          },
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
