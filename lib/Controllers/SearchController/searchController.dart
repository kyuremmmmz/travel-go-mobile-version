import 'package:TravelGo/main.dart';

class Searchcontroller {
  Future<List<dynamic>> fetchSuggestions(String query) async {
    try {
      final response = await supabase
          .from('places')
          .select('*')
          .ilike('place_name', '%$query%');

      if (response.isNotEmpty) {
        final data = response;
        List datas = List.from(data);
        for (var quesries in datas) {
          final place = quesries['place_name'];
          final img = quesries['image'];
          final imgUrl = await getter(img);
          quesries['image'] = imgUrl;
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

  Future<String?> getter(String imgUrl) async {
    final response = supabase.storage.from('places_url').getPublicUrl(imgUrl);
    if (response.isEmpty) {
      return null;
    } else {
      return response;
    }
  }

  Future<List<dynamic>> fetchHotelSuggestions(String query) async {
    try {
      final response = await supabase
          .from('hotels')
          .select('*')
          .ilike('hotel_name', '%$query%');

      if (response.isNotEmpty) {
        final data = response;
        List datas = List.from(data);
        for (var quesries in datas) {
          final place = quesries['hotel_name'];
          final img = quesries['image'];
          final imgUrl = await Hotelgetter(img);
          quesries['image'] = imgUrl;
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

  Future<String?> Hotelgetter(String imgUrl) async {
    final response = supabase.storage.from('places_url').getPublicUrl(imgUrl);
    if (response.isEmpty) {
      return null;
    } else {
      return response;
    }
  }
}
