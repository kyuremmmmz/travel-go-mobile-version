import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login {
  late final String email;
  late final String password;

  Login({required this.email, required this.password});
  Future<void> loginUser(BuildContext context) async {
    final SupabaseClient supabase = Supabase.instance.client;

    final AuthResponse response = await supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );
    final User? user = response.user;
    final Session? session = response.session;
    if (user != null && session != null) {
      await Future.delayed(const Duration(
        seconds: 2,
      ));
      const Home();
    } else {
      ScaffoldMessenger
              // ignore: use_build_context_synchronously
              .of(context)
          .showSnackBar(
        const SnackBar(
          content: Text('Failed to login. Please check your credentials.'),
        ),
      );
    }
  }
}
