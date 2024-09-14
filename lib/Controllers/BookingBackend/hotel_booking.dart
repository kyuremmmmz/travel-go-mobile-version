import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelBooking {
  final supabase = Supabase.instance.client;
  Future<Map<String, dynamic>?> passtheData(int id) async {
    final response = await supabase
        .from('places')
        .select('id, place_name, price')
        .eq('id', id)
        .single();
    if (response.isEmpty) {
      print('no data found');
      return null;
    } else {
      final data = response;
      var place = data['place_name'];
      var price = data['price'];
      final priceQ = NumberFormat('#,###');
      final formatPrice = priceQ.format(price);
      data['place_name'] = place;
      data['price'] = formatPrice;
      print(price);
      print(place);
      return data;
    }
  }

  Future<Map<String, dynamic>?> passTheHotelData(int id) async {
    final response = await supabase
        .from('hotels')
        .select('id, hotel_name, hotel_price')
        .eq('id', id)
        .single();
    try {
      if (response.isEmpty) {
        print('no data found');
        return null;
      } else {
        final data = response;
        var hotel = data['hotel_name'];
        var hotelPrice = data['hotel_price'];
        final priceQ = NumberFormat('#,###');
        final formatPrice = priceQ.format(hotelPrice);
        data['hotel_name'] = hotel;
        data['hotel_price'] = formatPrice;
        return data;
      }
    } catch (e) {
      SnackBar(
          content: Text('an error occurred while formatting the data: $e'));
    }
    return null;
  }

//TODO: implement this to upsert method
  Future<PostgrestResponse<dynamic>?> insertBooking
  (
    String fullname, 
    String emailAddress,  
    int phoneNumber, 
    String hotel, 
    String checkIn, 
    String checkOut, 
    String paymentMethod,
    int numberOfAdult, 
    int NumberOfChildren,
    
    ) async {

  }
}
