import 'package:TravelGo/Controllers/TRGO_POINTS/Trgo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletPaymentScreen extends StatefulWidget {
  final double walletBalance;
  final num payments;

  WalletPaymentScreen({required this.walletBalance, required this.payments});

  @override
  _WalletPaymentScreenState createState() => _WalletPaymentScreenState();
}

class _WalletPaymentScreenState extends State<WalletPaymentScreen> {
  final _paymentController = TextEditingController();
  final _currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '₱');
  double? paymentAmount;
  String? errorMessage;
  final trGoMoney = Trgo();

  Stream<int> get moneyStream async* {
    while (true) {
      final response = await trGoMoney.fetchMoney();
      yield response!['money'];
      await Future.delayed(Duration(seconds: 5)); // Adjust the delay as needed
    }
  }

  @override
  void dispose() {
    _paymentController.dispose();
    super.dispose();
  }

  void _onPay() {
    setState(() {
      paymentAmount = double.tryParse(_paymentController.text);
      if (paymentAmount == null) {
        errorMessage = "Please enter a valid amount.";
      } else if (paymentAmount! > widget.walletBalance) {
        errorMessage = "Insufficient balance.";
      } else if (paymentAmount! < widget.payments) {
        errorMessage =
            "Payment amount must be at least ${_currencyFormat.format(widget.payments)}.";
      } else {
        errorMessage = null;
        final newBalance = widget.walletBalance - paymentAmount!;
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
                "Total Payments Made: ${_currencyFormat.format(widget.payments + paymentAmount!)}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
            StreamBuilder<int>(
              stream: moneyStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading wallet balance...");
                } else if (snapshot.hasError) {
                  return Text("Error loading wallet balance");
                } else {
                  return Column(
                    children: [
                      Text(
                        "Wallet Balance: ${_currencyFormat.format(snapshot.data)}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Price to pay: ${_currencyFormat.format(widget.payments)}",
                        style: TextStyle(
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
