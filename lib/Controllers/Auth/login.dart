import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login {
  late final String email;
  late final String password;

  Login({required this.email, required this.password});
  Future<void> loginUser(BuildContext context) async {
    final SupabaseClient supabase = Supabase.instance.client;
    try {
      await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
