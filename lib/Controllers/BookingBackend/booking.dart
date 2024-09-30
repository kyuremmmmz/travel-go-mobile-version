import 'package:supabase_flutter/supabase_flutter.dart';

class Booking {
  final supabase = Supabase.instance.client;

  Future<PostgrestResponse> insertBooking(int id) async {
    final response = await supabase.from('').insert({
      
    });
    return response;
  }
}
