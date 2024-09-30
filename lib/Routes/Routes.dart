// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/booking_area.dart';
import 'package:itransit/Widgets/Screens/App/creditcard.dart';
import 'package:itransit/Widgets/Screens/App/hotel_booking.dart';
import 'package:itransit/Widgets/Screens/App/notPaid.dart';
import 'package:itransit/Widgets/Screens/App/orderReceipt.dart';
import 'package:itransit/Widgets/Screens/Stateless/beaches_stateless.dart';
import 'package:itransit/Widgets/Screens/Stateless/email.dart';
import 'package:itransit/Widgets/Screens/Stateless/explore.dart';
import 'package:itransit/Widgets/Screens/Stateless/festivalsStateless.dart';
import 'package:itransit/Widgets/Screens/Stateless/food_AreaStateless.dart';
import 'package:itransit/Widgets/Screens/Stateless/forgot.dart';
import 'package:itransit/Widgets/Screens/Stateless/hotel_stateless.dart';
import 'package:itransit/Widgets/Screens/Stateless/reset.dart';
import 'package:itransit/Widgets/Screens/WidgetTestingScreen/testWidget.dart';

import '../Widgets/Screens/App/foodAreaAbout.dart';
import '../Widgets/Screens/App/mainmenu.dart';
import '../Widgets/Screens/Auth/Login.dart';
import '../Widgets/Screens/Auth/Signup.dart';
import './../Widgets/Screens/App/linkedBankAccount.dart';

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

  static void navigateToLinkedBankAccount(
    BuildContext route, {
    required String name,
    required int phone,
    required String nameoftheplace,
    required int price,
    required int payment,
    required String hotelorplace,
  }) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => LinkedBankScreen(
                name: name,
                phone: phone,
                nameoftheplace: nameoftheplace,
                price: price,
                payment: payment,
                hotelorplace: hotelorplace)));
  }

  static void navigateToTesting(BuildContext route,
      {required String name, required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => Map(
                  location: name,
                  id: id,
                )));
  }

  static void navigateToOrderReceipt(
    BuildContext route, {
    required String name,
    required int phone,
    required DateTime date,
    required String ref,
    required String payment,
  }) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => OrderReceipt(
                  Phone: phone,
                )));
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

  static void navigateToFoodAreaAbout(BuildContext route, {required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => FoodAreaAbout(
                  id: id,
                )));
  }

  static void navigateToBeachesScreen(BuildContext route) {
    Navigator.push(route,
        MaterialPageRoute(builder: (context) => const BeachesStateless()));
  }

  static void navigateToFestivalsScreen(BuildContext route) {
    Navigator.push(route,
        MaterialPageRoute(builder: (context) => const FestivalsStateless()));
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

  static void navigateToNotPaid(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Notpaid()));
  }

  static void navigateTofoodArea(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FoodAreastateless()));
  }
}
