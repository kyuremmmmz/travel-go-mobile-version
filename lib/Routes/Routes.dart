import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/Stateless/email.dart';
import 'package:itransit/Widgets/Screens/Stateless/forgot.dart';
import 'package:itransit/Widgets/Screens/Stateless/reset.dart';
import '../Widgets/Screens/Auth/Login.dart';
import '../Widgets/Screens/Auth/Signup.dart';
import './../Widgets/Screens/App/home.dart';
import '../Widgets/Screens/App/mainmenu.dart';

class AppRoutes {
  static const String login = "../Widgets/Screens/Auth/Login.dart";
  static const String forgotPassword = "../Widgets/Screens/Auth/Forgot.dart";
  static const String signup = "../Widgets/Screens/Auth/Signup.dart";

  static void navigateTosignUp(BuildContext route) {
    Navigator.push(
        route,
        MaterialPageRoute(
          builder: (context) => const SignUpscreen(),
        ));
  }

  static void navigateToLogin(BuildContext route) {
    Navigator.push(
        route,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  static void navigateToHome(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const Home()));
  }

  static void navigateToForgotPassword(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const Forgotpassword()));
  }

  static void searchScreenNavigator(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  static void navigateToEmailScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const email()));
  }

  static void navigateToResetScreen(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (route) => const Resetpassword()));
  }

  static void navigateToMainMenu(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (route) => const Mainmenu()));
  }
}
