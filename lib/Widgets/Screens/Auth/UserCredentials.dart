import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/Auth/signup.dart';
import 'package:TravelGo/Widgets/Textfield/passwordField.dart';

import '../../Textfield/plainTextField.dart';
import './../../Buttons/DefaultButtons/BlueButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const UserCredentialsscreen());
}

class UserCredentialsscreen extends StatelessWidget {
  const UserCredentialsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: UserCredentialsScreen(),
    );
  }
}

class UserCredentialsScreen extends StatefulWidget {
  final BuildContext? context;
  final String? email;
  const UserCredentialsScreen({super.key, this.context, this.email});

  @override
  State<UserCredentialsScreen> createState() => _UserCredentialsScreenState();
}

class _UserCredentialsScreenState extends State<UserCredentialsScreen> {
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final signUp = Signup();
  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
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
            right: -30,
            left: -30,
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
                right: -30,
                left: -30, // Change as needed
                child: Image.asset(
                  'assets/images/icon/airplanelogo.png', // Replace with your image path
                  height: 450.h, // Adjust the size
                  width: 350.w, // Adjust the size
                ),
              ),
              SizedBox(
                height: 470.h,
                width: 510.w,
              )
            ]),
          ),
          Positioned(
            bottom: -320.h,
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
                    SizedBox(
                      height: 40.h, // the space between the img and email area
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 30.w,
                      padding: EdgeInsets.only(top: 0.w),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            labelText: 'Full name',
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
                      height: 10.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width -
                          30.w, // full name line area
                      padding: EdgeInsets.only(top: 0.w),
                      child: plainTextField(
                        controller: _userNameController,
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'User Name is required';
                          }
                          if (value.length <= 5) {
                            return 'Name is too short';
                          }
                          return null;
                        },
                        colorr: Colors.black,
                        text: 'Full name',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          30.w, // password line area
                      child: TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                            labelText: 'Age',
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
                      height: 10.h,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          30.w, // password line area
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            labelText: 'Full name',
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
