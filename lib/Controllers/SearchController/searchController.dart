import 'package:TravelGo/main.dart';

class Searchcontroller {
  Future<List<dynamic>> fetchSuggestions(String query) async {
    try {
      final response = await supabase.from('places').select('*').ilike('place_name', '%$query%');

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

  Future<List<dynamic>> fetchHotelSuggestions(String query) async {
    try {
      final response = await supabase.from('hotels').select('*').ilike('hotel_name', '%$query%');

      if (response.isNotEmpty) {
        final data = response;
        List datas = List.from(data);
        for (var quesries in datas) {
          final place = quesries['hotel_name'];
          quesries['hotel_name'] = place;
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
