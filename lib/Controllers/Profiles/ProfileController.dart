import 'package:supabase_flutter/supabase_flutter.dart';
class Usersss {
  late User? user;
  SupabaseClient supabase = Supabase.instance.client;

  Future<void> signout() async 
  {
    Future.delayed(
      Duration.zero
    );
    await supabase.auth.signOut();
  }

  Future <String?> fetchUser() async {
    user =  supabase.auth.currentUser;
    return user?.email;
  }
}