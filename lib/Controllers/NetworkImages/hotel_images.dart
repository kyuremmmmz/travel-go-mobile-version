import 'package:supabase_flutter/supabase_flutter.dart';

class HotelImages {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchHotels() async {
    try {
      final response = await 
      supabase
      .from('hotels')
      .select('*')
      .limit(1000)
      .order('hotel_ratings', ascending: true);
      if (response.isEmpty) {
        print('no hotels found');
        return [];
      } else {
        final data = response;

        List<Map<String, dynamic>> map = List<Map<String, dynamic>>.from(data as List);
        for (var map in data) {
          var place = map['hotel_name'];
          var image = map['image'];
          var imageUrl = await getter(image);
          map['image'] = imageUrl;
          map['hotel_name'] = place;
        }
        return map;
      }
    } catch (e) {
      print('Error fetching hotels: $e');
      return [];
    }
  }

  Future<String?> getter(String image) async {
    final response =
        supabase.storage.from('hotel_amenities_url').getPublicUrl(image);
    if (response.isEmpty) {
      return 'null';
    }
    return response;
  }

  Future<Map<String, dynamic>?> fetchDataInSingle(int id) async {
    try {
      final response = await supabase
         .from('hotels')
         .select('*')
         .eq('id', id)
         .single();

      if (response.isEmpty) {
        print('hotel not found');
        return null;
      } else {
        var map = response;
        var place = map['hotel_name'];
        var image = map['image'];
        var imageUrl = await getter(image);
        map['image'] = imageUrl;
        map['hotel_name'] = place;
        return map;
      }
    } catch (e) {
      print('Error fetching hotel data: $e');
      return null;
    }
  }
}
