// ignore: implementation_imports
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_map/src/layer/marker_layer/marker_layer.dart';
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
        debugPrint('no hotels found');
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
      debugPrint('Error fetching hotels: $e');
      return [];
    }
  }


  Future<List<Map<String, dynamic>>> fetchHotelsByplace(String located) async {
    try {
      final response = await supabase
          .from('hotels')
          .select('*').eq('hotel_located', located)
          .limit(1000)
          .order('hotel_ratings', ascending: true);
      if (response.isEmpty) {
        debugPrint('no hotels found');
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
      debugPrint('Error fetching hotels: $e');
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
        debugPrint("$priceQ");
        return datas;
      } else {
        debugPrint('No data found for $id');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching specific data: $e');
      return null;
    }
  }

  map(Marker Function(dynamic place) param0) {}
}
