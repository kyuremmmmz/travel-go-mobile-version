import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:itransit/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

class Paypal {
  Future<PostgrestResponse<dynamic>?> pay(
      BuildContext context,
      int total,
      String placeorhotel,
      int price,
      String name,
      int phone,
      String place) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: true,
            clientId:
                "ATnwIYaZ9cWqfItnNdbWUPwaSQ2p2Etw2VE8qFkFleha42r0-BeC8gY9A6BLbAUFjXLZs3PYRJMiRFs_",
            secretKey:
                "EJb4g4OByuupLnbAXwQuWdTETCA3WFjJWoKwNWfG_dR2IziBJckqrs1lpEqEQ86kpatpFYIfcjYbsIZ0",
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: [
              {
                "amount": {
                  "total": '$total',
                  "currency": "PHP",
                  "details": {
                    "subtotal": '$total',
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description": "The payment transaction description.",
                "payment_options": const {
                  "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
                },
                "item_list": {
                  "items": [
                    {
                      "name": placeorhotel,
                      "quantity": 1,
                      "price": price,
                      "currency": "PHP"
                    }
                  ],

                  // shipping address is not required though
                  "shipping_address": {
                    "recipient_name": name,
                    "city": place,
                    "country_code": "PH",
                    "phone": phone,
                  },
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              await supabase
                  .from('hotel_booking')
                  .upsert({'payment_status': 'paid'});
              print("onSuccess: $params");
            },
            onError: (error) {
              print("onError: $error");
            },
            onCancel: (params) {
              print('cancelled: $params');
            })));
    final user = supabase.auth.currentUser;
    final timestamp = getter();
    final data = await supabase.from('payment_table').insert({
      'payment_id': user!.id,
      'payment': total,
      'name_of_the_place': place,
      'place': place,
      'reference_number': timestamp,
      'phone': phone,
      'name': name,
      'price': price,
    });
    return data;
  }

  String? getter() {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Random random = Random();
    int randomNumber = 1000 + random.nextInt(9000);
    String referenceNumber = "REF-$timestamp-$randomNumber";
    return referenceNumber;
  }
}
