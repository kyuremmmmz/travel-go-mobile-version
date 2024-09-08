// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/booking_area.dart';
import 'package:itransit/Widgets/Screens/App/orderReceipt.dart';
import 'package:itransit/Widgets/Screens/Stateless/email.dart';
import 'package:itransit/Widgets/Screens/Stateless/explore.dart';
import 'package:itransit/Widgets/Screens/Stateless/forgot.dart';
import 'package:itransit/Widgets/Screens/Stateless/reset.dart';
import 'package:itransit/Widgets/Screens/WidgetTestingScreen/testWidget.dart';

import '../Widgets/Screens/App/mainmenu.dart';
import '../Widgets/Screens/Auth/Login.dart';
import '../Widgets/Screens/Auth/Signup.dart';
import './../Widgets/Screens/App/home.dart';

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
        route, MaterialPageRoute(builder: (route) => const MainMenuScreen()));
  }

  static void navigateToExploreNowScreen(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const explore()));
  }

  static void navigateToTesting(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const MapPage()));
  }

  static void navigateToOrderReceipt(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const OrderReceipt()));
  }

  static void navigateToBookingArea(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const BookingArea()));
  }
}
