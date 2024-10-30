import 'package:TravelGo/Controllers/Transactions/BackendTransactions.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  String formatPrice(double price) {
    final num = NumberFormat('#,###.#');
    final price2 = num.format(price);
    return price2;
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
                  amount: 'PHP ${formatPrice(item['price'])}',
                  icon: item['pay_via'] == 'paypal'
                      ? Icons.paypal
                      : Icons.credit_card,
                  name: item['name'],
                  phone: item['phone'].toString(),
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
    required String phone,
    required String ref,
    required String payment,
    required String bookingId,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        leading: Icon(icon, size: 40.sp, color: Colors.blueAccent),
        title: Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          date,
          style: TextStyle(
            fontSize: 8.sp,
          ),
        ),
        trailing: Text(
          amount.toString(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        onTap: () {
          AppRoutes.navigateToOrderReceipt(context,
              name: name,
              phone: int.parse(phone),
              date: DateTime.parse(data),
              ref: ref,
              payment: payment.toString(),
              bookingId: bookingId);
        },
      ),
    );
  }
}
