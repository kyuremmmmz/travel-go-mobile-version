import 'package:flutter/material.dart';
import 'package:TravelGo/Widgets/Screens/Auth/Forgot.dart';
class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'forgot password page',
      home: ForgotPasswordScreen(),
    );
  }
}