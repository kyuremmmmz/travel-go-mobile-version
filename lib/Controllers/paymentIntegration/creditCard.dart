import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

class CreditcardBackend {
  final supabase = Supabase.instance.client;
  Future<void> payViaCredit(int payment, int price, String gmail, String name,
      int phone) async {
    final response = await supabase.from('payment_table').insert({
      'payment': payment,
      'price': price,
      'gmail': gmail,
      'reference_number': getter(),
      'payment_id': supabase.auth.currentUser!.id,
      'name': name,
      'phone': phone,
      'pay_via': 'Credit card',
    });
    await supabase.from('hotel_booking').update({
      'paymet_status': 'Paid',
    });
    if (response) {
      return response;
    }
  }

  String getter() {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Random random = Random();
    int randomNumber = 1000 + random.nextInt(9000);
    String referenceNumber = "REF-$timestamp-$randomNumber";
    return referenceNumber;
  }
}
