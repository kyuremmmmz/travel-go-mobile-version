import 'package:supabase_flutter/supabase_flutter.dart';
class Usersss {
  late User? user;
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> signout() async 
  {
    await supabase.auth.signOut();
    AuthResponse res  = await supabase.auth.refreshSession();
    res.session;
  }

  Future <String?> fetchUser() async {
    user =  supabase.auth.currentUser;
    return user?.email;
  }
}