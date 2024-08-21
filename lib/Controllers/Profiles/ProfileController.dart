import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/Auth/Choose.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class Usersss {
  late User? user;
  SupabaseClient supabase = Supabase.instance.client;

  Future <void> signout(BuildContext context) async {
    await supabase.auth.signOut();
    supabase.auth.currentSession == null ? const Welcomepage() : null;
  }

  Future <dynamic> fetchUser() async {
    user =  supabase.auth.currentUser;

    if (user == null) {
        return null;
    }
    else {
      return user?.email;
    }
  }
}