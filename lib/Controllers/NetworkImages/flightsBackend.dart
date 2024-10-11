import 'package:supabase_flutter/supabase_flutter.dart';

class Flightsbackend {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> flightList() async {
    final response = supabase.from('flightsList').select('*').eq('ticket_type', 'cheapest');
    return [];
  }

  Future<List<Map<String, dynamic>>> flightListBest() async {
    final response =
        supabase.from('flightsList').select('*').eq('ticket_type', 'best');
    return [];
  }

  Future<List<Map<String, dynamic>>> flightListFastest() async {
    final response = supabase.from('flightsList').select('*').eq('ticket_type', 'best');
    return [];
  }
}