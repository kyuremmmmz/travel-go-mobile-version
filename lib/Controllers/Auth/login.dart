import 'package:supabase_flutter/supabase_flutter.dart';
class Login {
  late String email;
  late String password;

  Login
  ({
    required this.email, 
    required this.password
  });

  Future<Map <String, String>> loginUser() async {
    final SupabaseClient supabase = Supabase.instance.client;

    final response = await supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );
    final Session? session = response.session;
    final User? user = response.user;

    try {
      // ignore: unrelated_type_equality_checks
      if (user != null && session != null) 
        {
        return 
        {
          'status code': '200', 
          'data': 'User logged in successfully'};
        }
        else
        {
          return 
            {
              'status code': '401', 
              'error': 'Invalid credentials'
            };
        }
    } catch (e) {
      return{
        'status code': '404',
        'error': 'User not found $e'
      };
    }
  }
}