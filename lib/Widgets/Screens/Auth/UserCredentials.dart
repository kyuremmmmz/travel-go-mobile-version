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
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0.h,
            right: -30,
            left: -30,
            child: Stack(children: <Widget>[
              Align(
                child: Image.asset(
                  'assets/images/icon/newlogo2.png',
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
                  'assets/images/icon/pogi2.png', // Replace with your image path
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
            top: 350.h,
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
                    padding: EdgeInsets.only(right: 50.w, left: 15.w, top: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Set Up Your Profile',
                          style: TextStyle(
                            color: const Color(0xFF2D3F4E),
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 5.h), // Add some space between the title and the message
                        Padding(
                          padding: EdgeInsets.only(bottom: 20, top: 0.h), // Adjust vertical padding as needed
                          child: Text(
                            'Welcome! Let’s get your profile set up so you can make the most of your experience.',
                            style: TextStyle(
                              color: const Color(0xFF3564C0), // Adjust color as needed
                              fontSize: 11.sp, // Adjust font size as necessary
                              fontWeight: FontWeight.w400, // Change weight if desired
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    Container(
                      width: MediaQuery.of(context).size.width - 30.w,
                      padding: EdgeInsets.only(top: 0.w, left: 5, right: 5),
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
                        decoration: const InputDecoration(
                            labelText: 'Full Name',
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
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width -
                          30.w, // full name line area
                      padding: EdgeInsets.only(top: 0.w, left: 5, right: 5),
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
                        padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0), // Customize padding as needed
                        width: MediaQuery.of(context).size.width - 30.w, // password line area
                        child: TextFormField(
                          controller: _phoneController,
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Phone Number is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                            labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                    Container(
                        padding: EdgeInsets.only(top: 0.w, left: 5, right: 5), //container of Next button to 
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
                            }))
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