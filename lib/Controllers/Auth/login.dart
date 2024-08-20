
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Supabase/key.dart';
import './../../Routes/Routes.dart';
class Login {
  late final String email;
  late final String password;

  Login({required this.email, required this.password});
  Future<void> loginUser() async {
    
    Supabase.initialize(url: url, anonKey: apikey);
    final SupabaseClient supabase = Supabase.instance.client;
    
    final AuthResponse response = await supabase.auth.signInWithPassword
    (
      password: password,
      email: email,
    );
    final Session? session = response.session;
    final User? user = response.user;
    
    if (session!= null && user!= null) {
      (context)=> AppRoutes.navigateToHome(context);
    }
  }
}