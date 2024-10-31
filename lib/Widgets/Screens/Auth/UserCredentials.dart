import 'package:TravelGo/Widgets/Screens/Auth/Signup.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/Auth/signup.dart';
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
  final _addresController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final signUp = Signup();
  Text? text;
  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _addresController.dispose();
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
                  child: Image.asset('assets/images/icon/newlogo-crop.png',
                      fit: BoxFit.cover, height: 120.sp),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          'Set Up Your Profile',
                          style: TextStyle(
                            color: const Color(0xFF2D3F4E),
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        )),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Text(
                        'Welcome, new traveler! Let’s get your profile set up so you can make the most of your experience.',
                        style: TextStyle(
                          color:
                              const Color(0xFF3564C0), // Adjust color as needed
                          fontSize: 13.sp, // Adjust font size as necessary
                          fontWeight:
                              FontWeight.w400, // Change weight if desired
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                        height: 15
                            .h), // Add some space between the title and the message
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Full name is required';
                          }
                          if (value.length <= 5) {
                            return 'Name is too short';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            alignLabelWithHint: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.w),
                            labelStyle:
                                TextStyle(fontSize: 15.sp, color: Colors.black),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w), // full name line area
                      child: plainTextField(
                        controller: _userNameController,
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'User name is required';
                          }
                          if (value.length <= 5) {
                            return 'Name is too short';
                          }
                          return null;
                        },
                        colorr: Colors.black,
                        text: 'User Name',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w), // password line area
                      child: TextFormField(
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return 'Phone Number is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          alignLabelWithHint: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5.0),
                          labelStyle:
                              TextStyle(fontSize: 15.sp, color: Colors.black),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Container(
                        width: 250.w, //container of Next button to
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
                              'Next',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen(
                                              fullName:
                                                  _nameController.text.trim(),
                                              phoneNumber: int.parse(
                                                  _phoneController.text.trim()),
                                              userName: _userNameController.text
                                                  .trim(),
                                              error: Text('$text'),
                                            )));
                              }
                            })),
                    SizedBox(height: 50.h)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}