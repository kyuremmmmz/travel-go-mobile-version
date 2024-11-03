import 'package:TravelGo/Controllers/TRGO_POINTS/Trgo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WithdrawScreen extends StatefulWidget {
  final num initialBalance;

  WithdrawScreen({
    Key? key,
    required this.initialBalance,
  }) : super(key: key);

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController amountController = TextEditingController();
  final List<String> transferOptions = ['Credit Card', 'PayPal'];
  final trgo = Trgo();
  num? bal;
  num? remainingBalance;
  @override
  void initState() {
    super.initState();
    remainingBalance = widget.initialBalance;
  }

  Future<void> getBal() async {
    final response = await trgo.getTheWithdrawPoints();
    setState(() {
      bal = response!['withdrawablePoints'] - amountController.text;
    });
  }

  Future<void> withdraw(double amount, BuildContext context) async {
    await trgo.withDraw(amount, context);
  }

  void _updateBalance() {
    num amount = num.tryParse(amountController.text) ?? 0.0;
    if (amount <= remainingBalance!) {
      setState(() {
        remainingBalance = widget.initialBalance - amount;
      });
    } else {
      setState(() {
        remainingBalance = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw Funds'),
        backgroundColor: Color(0xFF0E4DA4), // GCash-like blue color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${remainingBalance!.toStringAsFixed(2)} Points',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0E4DA4), // GCash-like blue color
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Enter Amount to Withdraw',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (text) {
                  _updateBalance(); // Update the balance in real-time
                },
                decoration: InputDecoration(
                  hintText: 'Enter amount',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.teal[50],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Select Transfer Method',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.teal[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              items: transferOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                
              },
              hint: const Text('Select Transfer Method'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                withdraw(amount, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E4DA4),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Withdraw',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WithdrawScreen(
        initialBalance: 100.0), // Set your initial user balance here
  ));
}
