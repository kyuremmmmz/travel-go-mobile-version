import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class Usersss {
  late User? user;
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> signout(BuildContext context) async {
    await supabase.auth.signOut();
    // ignore: use_build_context_synchronously
    AuthResponse res  = await supabase.auth.refreshSession();
    
    if (res.session!=null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          'Refresh session $user'
        )
        )
      );
    }
    
    
  }

  Future <String?> fetchUser() async {
    user =  supabase.auth.currentUser;
    return user?.email;
  }
}