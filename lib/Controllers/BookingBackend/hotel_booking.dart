import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelBooking {
  late BuildContext context;
  final supabase = Supabase.instance.client;
  Future<Map<String, dynamic>?> passtheData(int id) async {
    final response = await supabase
        .from('places')
        .select('id, place_name, price')
        .eq('id', id)
        .single();
    if (response.isEmpty) {
      debugPrint('no data found');
      return null;
    } else {
      final data = response;
      var place = data['place_name'];
      var price = data['price'];
      final priceQ = NumberFormat('#,###');
      final formatPrice = priceQ.format(price);
      data['place_name'] = place;
      data['price'] = formatPrice;
      debugPrint(price);
      debugPrint(place);
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
        debugPrint('no data found');
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
    int price,
    int age,
  ) async {
    try {
      if (age < 18) {
        throw Exception("tangina mo gago");
      } else {
        final user = supabase.auth.currentUser;
        final response = await supabase.from('hotel_booking').insert({
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
          'room_type': room,
          'age': age,
        });
        return response;
      }
    } catch (e) {
      SnackBar(content: Text('error: $e'));
    }
    return null;
  }

  Future<Map<String, dynamic>?> paymentReceipt(int uid) async {
    final response = await supabase
        .from('payment_table')
        .select('*')
        .eq('phone', uid)
        .single();
    if (response.isEmpty) {
      return null;
    } else {
      final data = response;
      var account = data['name'];
      var phone = data['phone'];
      var dateOfPayment = data['date_of_payment'];
      var refNo = data['reference_number'];
      var payment = data['payment'];
      var email = data['gmail'];
      NumberFormat num = NumberFormat("#,###");
      final format = num.format(payment);
      DateTime current = DateTime.parse(dateOfPayment);
      data['name'] = account;
      data['phone'] = phone;
      data['date_of_payment'] = current;
      data['reference_number'] = refNo;
      data['payment'] = format;
      data['gmail'] = email;
      return data;
    }
  }
}
