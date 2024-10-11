import 'package:supabase_flutter/supabase_flutter.dart';

class Flightsbackend {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> flightList(int id) async {
    final response = supabase.from('flightsList').select('*').eq('id', id);
    return [];
  }
}
