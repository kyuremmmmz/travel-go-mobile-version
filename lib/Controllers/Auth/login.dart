
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class Login {
  late final String email;
  late final String password;

  Login({required this.email, required this.password});
  Future<void> loginUser() async {
    
    final SupabaseClient supabase = Supabase.instance.client;
    
    final AuthResponse response = await supabase.auth.signInWithPassword
    (
      password: password,
      email: email,
    );
    
    // ignore: unrelated_type_equality_checks
    (BuildContext context)=> {
          ScaffoldMessenger
          .of(context)
          .showSnackBar(
            SnackBar(content: Text('Logged in as ${response.user?.email}'))
          )
      };
    }
    
  }
