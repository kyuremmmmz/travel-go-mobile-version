import 'package:supabase_flutter/supabase_flutter.dart';

class Booking {
  final supabase = Supabase.instance.client;
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
  }
}
