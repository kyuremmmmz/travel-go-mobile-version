import 'package:flutter/material.dart';

import '../Widgets/Screens/Auth/Login.dart';
import '../Widgets/Screens/Auth/Signup.dart';
import './../Widgets/Screens/App/home.dart';
class AppRoutes {
    static const String login = "../Widgets/Screens/Auth/Login.dart";
    static const String forgotPassword = "../Widgets/Screens/Auth/Forgot.dart";
    static const String signup = "../Widgets/Screens/Auth/Signup.dart";

    static void navigateTosignUp(BuildContext route){
        Navigator.push
        (
          route, 
          MaterialPageRoute(builder: (context) => const signupScreen(),)
        );
    }

    static void navigateToLogin(BuildContext route){
        Navigator.push
        (
          route, 
          MaterialPageRoute(builder: (context) => const LoginScreen(),)
        );
    }

    static void navigateToHome(BuildContext route){
      Navigator.push(
        route, 
        MaterialPageRoute(builder: (context)=>const Home())
        );
    }

    static void navigateToForgotPassword(BuildContext route){
        Navigator.pushNamed(route, forgotPassword);
    }
}