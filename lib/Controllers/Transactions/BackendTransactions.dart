import 'package:supabase_flutter/supabase_flutter.dart';

class Backendtransactions {
  final supabase = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> getTheTransactionsDetails() async {
    try {
      final user = supabase.auth.currentUser!.id;
      final response = await supabase
          .from('payment_table')
          .select('*')
          .eq('payment_id', user);
      if (response.isEmpty) {
        return [];
      } else {
        final data = response;

        List<Map<String, dynamic>> payment =
            List<Map<String, dynamic>>.from(data as List);
        for (var datas in payment) {
          final name = datas['name'];
          final amount = datas['payment'];
          final date = datas['date_of_payment'];
          datas['name'] = name;
          datas['amount'] = amount;
          datas['date_of_payment'] = date;
        }
        return payment;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
