import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:itransit/Widgets/Screens/App/orderReceipt.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

class Paypal {
  final supabase = Supabase.instance.client;
  Future<void> pay(BuildContext context, int total, String placeorhotel,
      int price, String name, int phone, String place) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: true,
            clientId:
                "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
            secretKey:
                "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: [
              {
                "amount": {
                  "total": total.toString(), // Ensure this is a string
                  "currency": "PHP",
                  "details": {
                    "subtotal": total.toString(), // Ensure this is a string
                    "shipping": '0',
                    "shipping_discount": '0'
                  }
                },
                "description": "The payment transaction for $placeorhotel.",
                "item_list": {
                  "items": [
                    {
                      "name": placeorhotel,
                      "quantity": '1', // PayPal expects string for quantity
                      "price": price.toString(), // Ensure price is a string
                      "currency": "PHP"
                    }
                  ],
                  "shipping_address": {
                    "recipient_name": name,
                    "line1": "Binday",
                    "line2": "", // optional, if you have more address details
                    "city": "San Fabian",
                    "state": "Pangasinan", // Use the province
                    "country_code": "PH", // ISO code for the Philippines
                    "postal_code": "2433", // San Fabian's postal code
                    "phone": phone.toString(),
                  },
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              await supabase.from('hotel_booking').update({
                'paymet_status': 'paid',
              }).eq('phone', phone);
              print("onSuccess: $params");
            },
            onError: (error) {
              print("onError: $error");
            },
            onCancel: (params) {
              print('cancelled: $params');
            }),
      ),
    );

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
