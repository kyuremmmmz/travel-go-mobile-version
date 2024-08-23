import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Routes/Routes.dart';
class Usersss {
  late User? user;
  SupabaseClient supabase = Supabase.instance.client;

  Future <void> signout(BuildContext context) async {
    await supabase.auth.signOut();
    // ignore: use_build_context_synchronously
    AppRoutes.navigateToHome(context);
    
  }

  Future <String?> fetchUser() async {
    user =  supabase.auth.currentUser;
    return user?.email;
  }
}