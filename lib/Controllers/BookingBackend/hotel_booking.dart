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

  Future<PostgrestMap?> passTheHotelData(BuildContext context,int id) async {
    final response = await supabase
        .from('hotels')
        .select('id, hotel_name, hotel_price')
        .eq('id', id)
        .single();
    try {
      if (response.isEmpty) {
      } else {
        final data = response;
        var hotel = data['hotel_name'];
        var hotelPrice = data['hotel_price'];
        data['hotel_name'] = hotel;
        data['hotel_price'] = hotelPrice;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:  Text(
          'An error occurred while processing: $e'
          )
        )
      );
    }
    return null;
  }

  Future<PostgrestResponse<dynamic>?> insertBooking() async {}
}
