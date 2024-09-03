import 'dart:convert';

import 'package:http/http.dart' as http;
class Searchcontroller {
  Future<List<dynamic>> fetchSuggestions(String query) async {
    final headers = {
      'X-API-KEY': '2ed3f8f207ac5be7669b246d2924381911403f34',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse('https://google.serper.dev/places'),
        headers: headers,
        body: json.encode({"q": query, "location": "Philippines", "gl": "ph"}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final places = data['places'] as List<dynamic>;
        return places;
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}