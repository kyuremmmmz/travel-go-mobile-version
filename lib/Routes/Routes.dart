import 'package:flutter/material.dart';

import '../Widgets/Screens/Auth/Login.dart';
import '../Widgets/Screens/Auth/Signup.dart';
class AppRoutes {
    static const String login = "../Widgets/Screens/Auth/Login.dart";
    static const String forgotPassword = "../Widgets/Screens/Auth/Forgot.dart";
    static const String signup = "../Widgets/Screens/Auth/Signup.dart";

    static Route<dynamic> geneRateRoutes(RouteSettings settings){
        switch (settings.name) {
          case signup:
              return MaterialPageRoute(builder: (_)=>const signupScreen());
          case login:
              return MaterialPageRoute(builder: (_)=>const LoginScreen());
          default:
          return MaterialPageRoute(builder: (_)=>const Scaffold(
            body: Text(
              '404 | NOT FOUND'
            ),
          )
        );
      }
    }

    static void navigateTosignUp(BuildContext route){
        Navigator.pushNamed(route, signup);
    }

    static void navigateToLogin(BuildContext route){
        Navigator.pushNamed(route, login);
    }

    static void navigateToForgotPassword(BuildContext route){
        Navigator.pushNamed(route, forgotPassword);
    }
}