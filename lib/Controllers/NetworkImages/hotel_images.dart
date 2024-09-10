import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelImages {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchHotels() async {
    try {
      final response = await supabase
          .from('hotels')
          .select('*')
          .limit(1000)
          .order('hotel_ratings', ascending: true);
      if (response.isEmpty) {
        print('no hotels found');
        return [];
      } else {
        final data = response;

        List<Map<String, dynamic>> map =
            List<Map<String, dynamic>>.from(data as List);
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
      final response =
          await supabase.from('hotels').select('*').eq('id', id).single();

      if (response.isNotEmpty) {
        final datas = response;
        var amenities = <String, dynamic>{};
        var imageUrlForAmenities = <String, dynamic>{};
        //NOTE: THIS IS THE TEXT
        for (var i = 1; i <= 20; i++) {
          final key = 'amenity$i';
          final keyUrl = 'amenity${i}url';
          final image = await getter(keyUrl);
          final value = datas[key];
          final imageUrlValue = datas[image];
          if (value != null) {
            amenities[key] = value;
            imageUrlForAmenities[key] = imageUrlValue;
          }
        }
        var text = datas['hotel_name'];
        var image = datas['image'];
        var located = datas['hotel_located'];
        int price = datas['hotel_price'];
        var priceQ = NumberFormat('#,###');
        final formattedPrice = priceQ.format(price);
        final imageUrl = await getter(image);
        datas['image'] = imageUrl;
        datas['hotel_name'] = text;
        datas['hotel_located'] = located;
        datas['hotel_price'] = formattedPrice;
        print(priceQ);
        datas['amenities'] = amenities;
        datas['amenity_urls'] = imageUrlForAmenities;
        return datas;
      } else {
        print('No data found for $id');
        return null;
      }
    } catch (e) {
      print('Error fetching specific data: $e');
      return null;
    }
  }
}
