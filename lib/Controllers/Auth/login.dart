import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login {
  late final String email;
  late final String password;

  Login({required this.email, required this.password});
  Future<void> loginUser(BuildContext context) async {
    final SupabaseClient supabase = Supabase.instance.client;

    await supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );

    try {
      if (password == true) {}
    } catch (e) {}
  }
}
