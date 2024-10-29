import 'dart:convert';

import 'package:http/http.dart' as http;

class Tripcalculate {
  Future<String?> calculateData(String origin, String destination, String vehicle) async {
    final uri = Uri.parse('http://10.0.2.2:5000/calculate');
    final response = await http.post(uri,
        headers: {'content-type': 'application/json'},
        body: json.encode({
          'origin': origin,
          'destination': destination,
          'vehicle' : vehicle
        }));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['estimated_time'];
    }
    return null;
  }
}
