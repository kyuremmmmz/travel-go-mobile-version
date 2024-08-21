import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './../../Routes/Routes.dart';
//JUST A TEST MUNA ITONG JSON

class Signup {
  late final String? lastName;
  late final String? firstName;
  late final int? phoneNumber;
  late final int? age;
  late final String? address;
  late final String email;
  late final String password;
  late final Text error;

  

  Signup(
    {
      required this.email,
      required this.password,
      required this.error,
    }
  );

  Future<void> sign(BuildContext context) async {
    final supabase = Supabase.instance.client;
    try {
        final AuthResponse response = await supabase.auth.signUp(
          email: email,
          password: password,
          emailRedirectTo: kIsWeb ? null : "io.supabase.flutterquickstart://login-callback/",
        );
          final Session? session = response.session;
          final User? user = response.user;
        if (session != null && user != null) 
        {
          // ignore: use_build_context_synchronously
          AppRoutes.navigateToLogin(context);
          
        }
        else
        {
          ScaffoldMessenger
          // ignore: use_build_context_synchronously
          .of(context).showSnackBar(
            const SnackBar(
              content:
              Text('Error'),
            ),
          );
        }
    // ignore: empty_catches
    } catch (error) {
      ScaffoldMessenger
      // ignore: use_build_context_synchronously
      .of(context).showSnackBar(
        SnackBar(
          content:
          Text('Error: $error'),
        ),
      );
    }
  }
}

