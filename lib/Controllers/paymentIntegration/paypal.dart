import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class Paypal {
  final int total;
  final String currencyCode;
  final double subtotal;
  final int shipping;
  final int discount;

  const Paypal({
    required this.total,
    required this.currencyCode,
    required this.subtotal,
    required this.shipping,
    required this.discount,
  });

  Future<void> pay(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: true,
            clientId:
                "ATnwIYaZ9cWqfItnNdbWUPwaSQ2p2Etw2VE8qFkFleha42r0-BeC8gY9A6BLbAUFjXLZs3PYRJMiRFs_",
            secretKey:
                "EJb4g4OByuupLnbAXwQuWdTETCA3WFjJWoKwNWfG_dR2IziBJckqrs1lpEqEQ86kpatpFYIfcjYbsIZ0",
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: const [
              {
                "amount": {
                  "total": '10.12',
                  "currency": "USD",
                  "details": {
                    "subtotal": '10.12',
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description": "The payment transaction description.",
                "payment_options": {
                  "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
                },
                "item_list": {
                  "items": [
                    {
                      "name": "A demo product",
                      "quantity": 1,
                      "price": '10.12',
                      "currency": "USD"
                    }
                  ],

                  // shipping address is not required though
                  "shipping_address": {
                    "recipient_name": "Jane Foster",
                    "line1": "Travis County",
                    "line2": "",
                    "city": "Austin",
                    "country_code": "US",
                    "postal_code": "73301",
                    "phone": "+00000000",
                    "state": "Texas"
                  },
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              print("onSuccess: $params");
            },
            onError: (error) {
              print("onError: $error");
            },
            onCancel: (params) {
              print('cancelled: $params');
            })));
  }
}
