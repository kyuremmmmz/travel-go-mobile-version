import 'dart:convert';

import 'package:TravelGo/main.dart';
import 'package:http/http.dart' as http;

class Searchcontroller {
  Future<List<dynamic>> fetchSuggestions(String query) async {
    try {
      final response = await supabase.from('places').select('*');

      if (response.isNotEmpty) {
        final data = response;
        List datas = List.from(data);
        for (var quesries in datas) {
          final place = quesries['place_name'];
          quesries['place_name'] = place;
        }
        return datas;
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return [];
    }
  }
}
