import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//JUST A TEST MUNA ITONG JSON

class Signup {
  late final String? fullName;
  late final int? phoneNumber;
  late final int? age;
  late final String? address;
  late final String email;
  late final String password;
  late final Text error;

  Signup({
    required this.email,
    required this.fullName,
    required this.password,
  });

  Future<void> sign(BuildContext context) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.auth.signUp(
          email: email,
          password: password,
          emailRedirectTo:
              kIsWeb ? null : "io.supabase.flutterquickstart://login-callback/",
          data: {'full_name': fullName});
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Signed up Successfully check your email')));
      // ignore: empty_catches
    } catch (error) {
      ScaffoldMessenger
              // ignore: use_build_context_synchronously
              .of(context)
          .showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }
}
