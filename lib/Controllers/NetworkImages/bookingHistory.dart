import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Bookinghistory {
  final supabase = Supabase.instance.client;

  Future<PostgrestResponse<dynamic>?> insertBooking(
      String fullname,
      String emailAddress,
      int phoneNumber,
      String hotel,
      String checkIn,
      String checkOut,
      String paymentMethod,
      String paymentStatus,
      int numberOfAdult,
      int numberOfChildren,
      String room,
      var price) async {
    try {
      final user = supabase.auth.currentUser;
      final response = await supabase.from('booking_history').insert({
        'name': fullname,
        'gmail': emailAddress,
        'phone': phoneNumber,
        'price': price,
        'paymet_status': paymentStatus,
        'hotel': hotel,
        'booking_id': user!.id,
        'checkin': checkIn,
        'checkout': checkOut,
        'number_of_adults': numberOfAdult,
        'number_of_children': numberOfChildren,
        'room_type': room
      });
      return response;
    } catch (e) {
      SnackBar(content: Text('error: $e'));
    }
    return null;
  }
}
