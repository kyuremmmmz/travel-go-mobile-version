// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/booking_area.dart';
import 'package:itransit/Widgets/Screens/App/creditcard.dart';
import 'package:itransit/Widgets/Screens/App/hotel_booking.dart';
import 'package:itransit/Widgets/Screens/App/orderReceipt.dart';
import 'package:itransit/Widgets/Screens/Stateless/beaches_stateless.dart';
import 'package:itransit/Widgets/Screens/Stateless/email.dart';
import 'package:itransit/Widgets/Screens/Stateless/explore.dart';
import 'package:itransit/Widgets/Screens/Stateless/forgot.dart';
import 'package:itransit/Widgets/Screens/Stateless/hotel_stateless.dart';
import 'package:itransit/Widgets/Screens/Stateless/reset.dart';
import 'package:itransit/Widgets/Screens/WidgetTestingScreen/testWidget.dart';
import '../Widgets/Screens/App/mainmenu.dart';
import '../Widgets/Screens/Auth/Login.dart';
import '../Widgets/Screens/Auth/Signup.dart';
import './../Widgets/Screens/App/linkedBankAccount.dart';
import '../Widgets/Screens/App/foodAreaAbout.dart';

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

  static void navigateToLinkedBankAccount(BuildContext route) {
    Navigator.push(route,
        MaterialPageRoute(builder: (context) => const LinkedBankScreen()));
  }

  static void navigateToTesting(BuildContext route, {required String name}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => Map(
                  location: name,
                )));
  }

  static void navigateToOrderReceipt(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const OrderReceipt()));
  }

  static void navigateToBookingArea(BuildContext route, {required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => BookingArea(
                  id: id,
                )));
  }

  static void navigateToHotelScreen(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const HotelStateless()));
  }

  static void navigateToBeachesScreen(BuildContext route) {
    Navigator.push(route,
        MaterialPageRoute(builder: (context) => const BeachesStateless()));
  }

  static void navigateToFoodAreaAbout(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const FoodAreaAbout()));
  }

  static void navigateToHotelBookingScreen(BuildContext route,
      {required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (route) => HotelBookingArea(
                  id: id,
                )));
  }

  static void navigateToCreditCard(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Creditcard()));
  }
}
