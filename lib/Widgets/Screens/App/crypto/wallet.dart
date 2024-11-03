// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/TRGO_POINTS/Trgo.dart';
import 'package:TravelGo/Controllers/paymentIntegration/trgoIntegration.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Screens/App/orderReceipt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletPaymentScreen extends StatefulWidget {
  final String name;
  final int phone;
  final String hotelorplace;
  final String nameoftheplace;
  final num price;
  final double payment;
  final String booking_id;
  const WalletPaymentScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.hotelorplace,
    required this.nameoftheplace,
    required this.price,
    required this.payment,
    required this.booking_id,
  }) : super(key: key);

  @override
  _WalletPaymentScreenState createState() => _WalletPaymentScreenState();
}

class _WalletPaymentScreenState extends State<WalletPaymentScreen> {
  final _paymentController = TextEditingController();
  final _currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '₱');
  double? paymentAmount;
  String? errorMessage;
  final trGoMoney = Trgo();
  num walletBalance = 0.0;

  Stream<num> get moneyStream async* {
    while (true) {
      final response = await trGoMoney.fetchMoney();
      if (response != null) {
        walletBalance = response['money'].toDouble();
        yield response['money'];
      }
      await Future.delayed(Duration(seconds: 5));
    }
  }

  @override
  void dispose() {
    _paymentController.dispose();
    super.dispose();
  }

  void _onPay() {
    Trgointegration().payViaTrgo(
            widget.price,
            widget.price,
            widget.nameoftheplace,
            widget.name,
            widget.phone,
            widget.booking_id);
    setState(() {
      paymentAmount = double.tryParse(_paymentController.text);
      if (paymentAmount == null) {
        errorMessage = "Please enter a valid amount.";
      } else if (paymentAmount! > walletBalance) {
        errorMessage = "Insufficient balance.";
      } else if (paymentAmount! < widget.price) {
        errorMessage =
            "Payment amount must be at least ${_currencyFormat.format(widget.price)}.";
      } else {
        errorMessage = null;
        // Update the wallet balance directly
        final newBalance = walletBalance - paymentAmount!;
        _showTransactionDialog(newBalance);
        _paymentController.clear();
      }
    });
  }

  void _showTransactionDialog(double newBalance) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Transaction Successful",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("You have paid:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "${_currencyFormat.format(paymentAmount)}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                    SizedBox(height: 10),
                    Text("New Wallet Balance:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "${_currencyFormat.format(newBalance)}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Transaction ID: ${DateTime.now().millisecondsSinceEpoch}"),
            SizedBox(height: 10),
            Text(
                "Total Payments Made: ${_currencyFormat.format(widget.price + paymentAmount!)}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => {
              Navigator.push(context,MaterialPageRoute(
                                builder: (context) => OrderReceipt(
                                    bookingId: widget.booking_id
                                    )
                                  )
                                ),
              Navigator.pop(context)
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRGO WALLET"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<num>(
              stream: moneyStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading wallet balance...");
                } else if (snapshot.hasError) {
                  return const Text("Error loading wallet balance");
                } else {
                  return Column(
                    children: [
                      Text(
                        "Wallet Balance: ${_currencyFormat.format(snapshot.data?.toDouble() ?? 0.0)}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Price to pay: ${_currencyFormat.format(widget.price)}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _paymentController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Enter amount to pay",
                prefixIcon: Icon(Icons.money),
                border: OutlineInputBorder(),
                errorText: errorMessage,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onPay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Pay Now",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
