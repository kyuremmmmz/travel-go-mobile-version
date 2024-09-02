import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Usersss {
  late User? user;
  late Bool send;
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> signout(BuildContext context) async {
    Future.delayed(Duration.zero);
    await supabase.auth.signOut();
  }

  Future<PostgrestList> fetchUser() async {
    user = supabase.auth.currentUser;
    late String? name = user?.id;
    return await supabase
        .from('profiles')
        .select('full_name')
        .eq('id', name.toString());
  }

  Future<dynamic> sendVerificationCode(
      String? email, BuildContext context) async {
    try {
      await supabase.auth.resetPasswordForEmail(email!);

      // ignore: use_build_context_synchronously
      AppRoutes.navigateToEmailScreen(context);
    } catch (e) {
      if (email.toString().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill your email')));
      }
    }
  }

  Future<dynamic> resetPasssword(
      String? token, String? email, String? password) async {
    try {
      await supabase.auth
          .verifyOTP(email: email, token: token, type: OtpType.recovery);

      await supabase.auth.updateUser(UserAttributes(password: password));
      const SnackBar(content: Text('Password reset successfully'));
    } catch (e) {
      SnackBar(content: Text('error: $e'));
    }
  }
}
