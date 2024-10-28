import 'package:TravelGo/Controllers/Transactions/BackendTransactions.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<Map<String, dynamic>> transactions = [];
  Backendtransactions trans = Backendtransactions();

  Future<void> mapTheData() async {
    final response = await trans.getTheTransactionsDetails();
    setState(() {
      transactions = response;
    });
  }

  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    mapTheData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(10.0),
              children: transactions.map((item) {
                return _buildTransactionItem(
                  title: item['name'],
                  date: formatDate(item['date_of_payment']),
                  amount: '${item['price']}',
                  icon: item['pay_via'] == 'paypal'
                      ? Icons.paypal
                      : Icons.credit_card,
                  name: item['name'],
                  phone: item['phone'],
                  ref: item['reference_number'],
                  payment: item['price'].toString(),
                  bookingId: item['booking_id'], 
                  data: item['date_of_payment'],
                );
              }).toList(),
            ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String data,
    required String amount,
    required IconData icon,
    required String name,
    required int phone,
    required String ref,
    required String payment,
    required String bookingId,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(date),
        trailing: Text(
          amount.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        onTap: () {
          AppRoutes.navigateToOrderReceipt(context,
              name: name,
              phone: phone,
              date: DateTime.parse(data),
              ref: ref,
              payment: payment.toString(),
              bookingId: bookingId);
        },
      ),
    );
  }
}
