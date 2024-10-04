import 'package:supabase_flutter/supabase_flutter.dart';

class Booking {
  final supabase = Supabase.instance.client;
<<<<<<< HEAD

  Future<PostgrestResponse> insertBooking(int id) async {
    final response = await supabase.from('').insert({
      
    });
    return response;
=======
  Future<PostgrestResponse?> flightBooking(
    int id,
    String firstName,
    String lastName,
    String country,
    String phoneNumber,
    String email,
    String origin,
    String returnDate,
    String departureDate,
    String destination,
    int payment,
    String paymentMethod,
    String plane,
    String airPort,
    String travelType,
  ) async {
    return null;
>>>>>>> 2c60857ac80e5d7aabb0027883333f7b6c4dcdb4
  }
}
