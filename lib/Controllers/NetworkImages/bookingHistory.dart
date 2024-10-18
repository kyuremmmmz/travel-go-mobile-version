import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookinghistoryBackend {
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
      int age,
      var price) async {
    try {
      if (age < 18) {
        throw Exception("Age must be between 18 and older");
      }
    } catch (e) {
      SnackBar(content: Text('error: $e'));
    }
    return null;
  }

  Future<PostgrestMap?> getPlace(String hotel) async {
    try {
      final response = await supabase
          .from('hotels')
          .select('hotel_located')
          .eq('hotel_name', hotel)
          .single();
      final data = response;
      var locate = data['hotel_located'];
      data['hotel_located'] = locate;
      return data;
    } catch (e) {
      SnackBar(content: Text('error: $e'));
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getBookingHistory() async {
    try {
      final user = supabase.auth.currentUser;
      final response = await supabase
          .from('booking_history')
          .select('*')
          .eq('booking_id', user!.id);
      if (response.isNotEmpty) {
        final data = response;
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data as List);
        for (var datas in dataList) {
          final price = datas['price'];
          final hotel = datas['hotel'];
          final checkIn = datas['checkin'];
          final checkOut = datas['checkout'];
          final room = datas['room_type'];
          final bookingId = datas['booking_id'];
          final paymentStatus = datas['paymet_status'];
          datas['price'] = price;
          datas['hotel'] = hotel;
          datas['checkin'] = checkIn;
          datas['checkout'] = checkOut;
          datas['room_type'] = room;
          datas['booking_id'] = bookingId;
          datas['payment_status'] = paymentStatus;
        }
        return dataList;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
