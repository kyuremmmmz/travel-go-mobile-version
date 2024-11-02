import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletPaymentScreen extends StatefulWidget {
  final double walletBalance;

  WalletPaymentScreen({required this.walletBalance});

  @override
  _WalletPaymentScreenState createState() => _WalletPaymentScreenState();
}

class _WalletPaymentScreenState extends State<WalletPaymentScreen> {
  final _paymentController = TextEditingController();
  final _currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '₱');
  double? paymentAmount;
  String? errorMessage;

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
      } else {
        errorMessage = null;
        // Proceed with the payment logic
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Payment Successful"),
            content:
                Text("You have paid: ${_currencyFormat.format(paymentAmount)}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
        _paymentController.clear();
      }
    });
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
            Text(
              "Wallet Balance: ${_currencyFormat.format(widget.walletBalance)}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onPay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
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
