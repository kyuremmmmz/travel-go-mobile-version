import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signup {
  late final String? lastName;
  late final String? firstName;
  late final int? phoneNumber;
  late final int? age;
  late final String? address;
  late final String? email;
  late final String? password;

  Signup(
    {
      required this.email,
      required this.password,
    }
  );

  Future<Map<String, dynamic>> signUp() async {
    final supabase = Supabase.instance.client;
    try {
        final AuthResponse response = await supabase.auth.signUp(
          email: email!,
          password: password!,
        );
          final Session? session = response.session;
          final User? user = response.user;
        if (email != null && user != null) {
          return {
            'status': 200,
            'message': 'success',
            'data': {
              'user': user.email,
              'id': user.id,
              'adminOrNot': user.role == 'admin'? "you're in admin mode" : "you're in user mode"
            }
          };
        }
    // ignore: empty_catches
    } catch (error) {
      
    }
  }
}

