import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Flightsbackend {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> flightList() async {
    final response =
        supabase.from('flightsList').select('*').eq('ticket_type', 'cheapest');
    return [];
  }

  Future<List<Map<String, dynamic>>> flightListBest() async {
    final response = await supabase
        .from('flightsList')
        .select('*')
        .eq('ticket_type', 'best');
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;
      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in results) {
        var img = datas['airplane_img'];
        var name = datas['airport'];
        var pricePlace = datas['price'];
        var price = NumberFormat('#,###');
        var format = price.format(pricePlace);
        datas['airport'] = name;
        datas['price'] = format;
        var imgUrl = await getter(img);
        datas['airplane_img'] = imgUrl;
      }
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> flightListFastest() async {
    final response =
        supabase.from('flightsList').select('*').eq('ticket_type', 'best');
    return [];
  }

  Future<String?> getter(String name) async {
    final response = supabase.storage.from('flights').getPublicUrl(name);
    if (response.isEmpty) {
      return null;
    } else {
      return response;
    }
  }
}
