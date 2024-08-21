import 'package:supabase_flutter/supabase_flutter.dart';

class Usersss {
  late User? user;
  SupabaseClient supabase = Supabase.instance.client;

  void signOut() async {
    await supabase.auth.signOut();
    user = null;
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