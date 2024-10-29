// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Widgets/Screens/App/Transactions.dart';
import 'package:TravelGo/Widgets/Screens/App/allFlights.dart';
import 'package:TravelGo/Widgets/Screens/App/bookingHistory.dart';
import 'package:TravelGo/Widgets/Screens/App/booking_area.dart';
import 'package:TravelGo/Widgets/Screens/App/confirmBooking.dart';
import 'package:TravelGo/Widgets/Screens/App/creditcard.dart';
import 'package:TravelGo/Widgets/Screens/App/hotel_booking.dart';
import 'package:TravelGo/Widgets/Screens/App/maps/beachTrackerMaps.dart';
import 'package:TravelGo/Widgets/Screens/App/maps/exploreTrackerMaps.dart';
import 'package:TravelGo/Widgets/Screens/App/maps/festivalTrackerMaps.dart';
import 'package:TravelGo/Widgets/Screens/App/maps/foodPlacesTrackerMaps.dart';
import 'package:TravelGo/Widgets/Screens/App/maps/hotelTrackerMaps.dart';
import 'package:TravelGo/Widgets/Screens/App/notPaid.dart';
import 'package:TravelGo/Widgets/Screens/App/orderReceipt.dart';
import 'package:TravelGo/Widgets/Screens/Auth/UserCredentials.dart';
import 'package:TravelGo/Widgets/Screens/Profiles/Settings.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/beaches_stateless.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/email.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/explore.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/festivalsStateless.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/food_AreaStateless.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/forgot.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/hotel_stateless.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/reset.dart';
import 'package:TravelGo/Widgets/Screens/WidgetTestingScreen/testWidget.dart';
import 'package:TravelGo/main.dart';
import 'package:flutter/material.dart';
import '../Widgets/Screens/App/InfoScreens/FoodAreaInfo.dart';
import '../Widgets/Screens/App/mainmenu.dart';
import '../Widgets/Screens/Auth/Login.dart';
import './../Widgets/Screens/App/linkedBankAccount.dart';
import '../../Widgets/Screens/App/crypto/discountArea.dart';

class AppRoutes {
  static const String login = "../Widgets/Screens/Auth/Login.dart";
  static const String forgotPassword = "../Widgets/Screens/Auth/Forgot.dart";
  static const String signup = "../Widgets/Screens/Auth/Signup.dart";
  static void navigateTosignUp(BuildContext route) {
    Navigator.push(
        route,
        MaterialPageRoute(
          builder: (context) => const UserCredentialsScreen(),
        ));
  }

  static void navigateToLogin(BuildContext route) {
    Navigator.push(
        route,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  static void navigateToWelcomePage(BuildContext route) {
    Navigator.push(
        route,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ));
  }

  static void navigateToForgotPassword(BuildContext route) {
    Navigator.push(
        route, MaterialPageRoute(builder: (context) => const Forgotpassword()));
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

  static void nagigateToFlightScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Allflights()));
  }

  static void navigateToLinkedBankAccount(BuildContext route,
      {required String name,
      required int phone,
      required String nameoftheplace,
      required int price,
      required int payment,
      required String hotelorplace,
      required int age,
      String? origin,
      String? destination,
      String? bookingId}) {
    try {
      if (age < 18) {
        throw Exception('You must be 18 years old or older');
      } else {
        Navigator.push(
            route,
            MaterialPageRoute(
                builder: (context) => LinkedBankScreen(
                      name: name,
                      phone: phone,
                      nameoftheplace: nameoftheplace,
                      price: price,
                      payment: payment,
                      hotelorplace: hotelorplace,
                      origin: origin,
                      destination: destination,
                      age: age,
                      bookingId: bookingId,
                    )));
      }
      return;
    } catch (e) {
      print('Error: $e');
    }
  }

  static void navigateToHotelMapPage(BuildContext route,
      {required String name, required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => HotelMapPage(location: name, id: id)));
  }

  static void navigateToExploreMapPage(BuildContext route,
      {required String name, required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => ExploreMapPage(location: name, id: id)));
  }

  static void navigateToFoodPlaceMapPage(BuildContext route,
      {required String name, required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => FoodPlaceMapPage(location: name, id: id)));
  }

  static void navigateToBeachMapPage(BuildContext route,
      {required String name, required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => BeachMapPage(location: name, id: id)));
  }

  static void navigateToFestivalsMapPage(BuildContext route,
      {required String name, required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => FestivalsMapPage(location: name, id: id)));
  }

  static void navigateToTesting(BuildContext route,
      {required String name, required int id}) {
    Navigator.push(route,
        MaterialPageRoute(builder: (context) => Mapa(location: name, id: id)));
  }

  static void navigateToOrderReceipt(BuildContext route,
      {required String name,
      required int phone,
      required DateTime date,
      required String ref,
      required String payment,
      required String bookingId}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => OrderReceipt(
                  bookingId: bookingId,
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

  static void navigateToFoodAreaInfo(BuildContext route, {required int id}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (context) => FoodAreaInfo(
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

  static void navigateToAccountSettings(BuildContext route) {
    Navigator.push(route,
        MaterialPageRoute(builder: (context) => const AccountSettingsScreen()));
  }

  static void navigateToHotelBookingScreen(BuildContext route,
      {required int id, required String price}) {
    Navigator.push(
        route,
        MaterialPageRoute(
            builder: (route) => HotelBookingArea(
                  id: id,
                  price: price,
                )));
  }

  static void navigateToCreditCard(BuildContext context,
      {required String name,
      required int phone,
      required String hotelorplace,
      required String nameoftheplace,
      required int price,
      required int payment,
      required int age,
      required String bookingId}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Creditcard(
                  name: name,
                  phone: phone,
                  hotelorplace: hotelorplace,
                  nameoftheplace: nameoftheplace,
                  price: price,
                  payment: payment,
                  booking_id: bookingId,
                )));
  }

  static void navigateToNotPaid(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Notpaid()));
  }

  static void navigateTofoodArea(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FoodAreastateless()));
  }

  static void navigateToDiscountArea(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DiscountArea()));
  }

  static void navigateToNextScreen(BuildContext context,
      {required id,
      required name,
      required email,
      required phone,
      required age,
      required country,
      required numberOfChildren,
      required numberOfAdults,
      required paymentMethod,
      required price,
      required last,
      String? bookingId}) {
    if (age < 18) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must be 18 years or older'),
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmBookingAreaScreen(
                    id: id,
                    name: name,
                    email: email,
                    phone: phone,
                    age: age,
                    country: country,
                    numberOfChildren: numberOfChildren,
                    numberOfAdults: numberOfAdults,
                    paymentMethod: paymentMethod,
                    price: price,
                    last: last,
                    bookingId: '$bookingId',
                  )));
    }
  }

  static void navigateToBookingHistory(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const BookingHistory()));
  }

  static void navigateToTransactionsScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Transactions()));
  }
}
