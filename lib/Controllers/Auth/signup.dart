import 'package:supabase_flutter/supabase_flutter.dart';
//JUST A TEST MUNA ITONG JSON
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

  Future<Map<String, dynamic>> sign() async {
    final supabase = Supabase.instance.client;
    try {
        final AuthResponse response = await supabase.auth.signUp(
          email: email!,
          password: password!,
        );
          final Session? session = response.session;
          final User? user = response.user;
        if (session != null && user != null) 
        {
          return {
            'status': 200,
            'message': 'success',
            'data': {
              'user': user.email,
              'id': user.id,
              'adminOrNot': user.role == 'admin'? "you're in admin mode" : "you're in user mode",
              'phone': user.phone,
            },
            'session':{
              'token': session.accessToken,
              'refresherToken': session.refreshToken,
              'expiresIn': session.expiresIn,
              'expiresAfter': session.expiresAt
            }
          };
        }
        else
        {
          return {
            'statusCode': '401',
            'response': 'not authorized',
          };
        }
    // ignore: empty_catches
    } catch (error) {
      return {
        'statusCode': '500',
       'response': 'internal server error',
        'error': error.toString(),
      };
    }
  }
}

