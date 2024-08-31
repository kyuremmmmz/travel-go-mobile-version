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

  Future<String?> fetchUser() async {
    user = supabase.auth.currentUser;
    return user?.email;
  }

  Future<void> sendVerificationCode(String? email, BuildContext context) async {
    await supabase.auth.resetPasswordForEmail(email!);

    // ignore: use_build_context_synchronously
    AppRoutes.navigateToEmailScreen(context);
  }
}
