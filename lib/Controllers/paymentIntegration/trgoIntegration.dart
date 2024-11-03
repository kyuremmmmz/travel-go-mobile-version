import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

class Trgointegration {
  final supabase = Supabase.instance.client;
  Future<void> payViaTrgo(num payment, num price, String gmail,
      String name, int phone, String? bookingId) async {
    final response = await supabase.from('payment_table').insert({
      'payment': payment,
      'price': price,
      'gmail': gmail,
      'reference_number': getter(),
      'payment_id': supabase.auth.currentUser!.id,
      'name': name,
      'phone': phone,
      'pay_via': 'TRGO COINS',
      'booking_id': bookingId
    });
    await supabase.from('hotel_booking').update({
      'paymet_status': 'Paid',
    }).eq('phone', phone);
    await supabase.from('booking_history').update({
      'paymet_status': 'Paid',
    }).eq('phone', phone);
    return response;
  }

  String getter() {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Random random = Random();
    int randomNumber = 1000 + random.nextInt(9000);
    String referenceNumber = "REF-$timestamp-$randomNumber";
    return referenceNumber;
  }
}
