import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login {
  late final String email;
  late final String password;
  final SupabaseClient supabase = Supabase.instance.client;
  Login({required this.email, required this.password});
  Future<void> loginUser(BuildContext context) async {
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
