import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BeachImages {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchBeaches() async {
    try {
      final response = await supabase
          .from('beaches')
          .select('*')
          .limit(1000)
          .order('beach_ratings', ascending: true);
      if (response.isEmpty) {
        print('no beaches found');
        return [];
      } else {
        final data = response;

        List<Map<String, dynamic>> map =
            List<Map<String, dynamic>>.from(data as List);
        for (var map in data) {
          var place = map['beach_name'];
          var image = map['image'];
          var imageUrl = await getter(image);
          map['image'] = imageUrl;
          map['beach_name'] = place;
        }
        return map;
      }
    } catch (e) {
      print('Error fetching beaches: $e');
      return [];
    }
  }

  Future<String?> getter(String image) async {
    final response =
        supabase.storage.from('beach_amenities_url').getPublicUrl(image);
    if (response.isEmpty) {
      return 'null';
    }
    return response;
  }

  Future<Map<String, dynamic>?> getSpecificData(int id) async {
    try {
      final response =
          await supabase.from('beaches').select('*').eq('id', id).single();

      if (response.isNotEmpty) {
        final datas = response;
        //NOTE: THIS IS THE TEXT
        for (var i = 1; i <= 20; i++) {
          final amenity = 'amenity$i';
          final amenityUrl = 'amenity${i}Url';
          final amenityValue = datas[amenity];
          final amenityUrlValue = datas[amenityUrl];
          if (amenityValue != null && amenityUrlValue != null) {
            final getters = await getter(amenityUrlValue);
            datas['amenity$i'] = amenityValue;
            datas['amenity${i}Url'] = getters;
          }
        }
        var text = datas['beach_name'];
        var image = datas['image'];
        var located = datas['beach_located'];
        int price = datas['beach_price'];
        var priceQ = NumberFormat('#,###');
        final formattedPrice = priceQ.format(price);
        final imageUrl = await getter(image);
        datas['image'] = imageUrl;
        datas['beach_name'] = text;
        datas['beach_located'] = located;
        datas['beach_price'] = formattedPrice;
        print(priceQ);
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
