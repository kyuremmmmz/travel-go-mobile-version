import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BeachImages {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchBeaches() async {
    final response = await supabase.from('Beaches').select('*');
    try {
      if (response.isEmpty) {
        return [];
      } else {
        final data = response;

        List<Map<String, dynamic>> result =
            List<Map<String, dynamic>>.from(data as List);
        for (var datas in result) {
          var name = datas['beach_name'];
          var imgUrl = datas['image'];
          var imgFinal = await getter(imgUrl);
          datas['image'] = imgFinal;
          datas['beach_name'] = name;
        }
        return data;
      }
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  Future<String?> getter(String name) async {
    final storage = supabase.storage.from('beaches').getPublicUrl(name);
    return storage;
  }

  Future<Map<String, dynamic>?> getSpecificData(int id) async {
    try {
      final response = await supabase.from('Beaches').select('*').eq('id', id).single();

      if (response.isNotEmpty) {
        final datas = response;
        //NOTE: THIS IS THE TEXT
        for (var i = 1; i <= 20; i++) {
          final amenity = 'dine$i';
          final amenityUrl = 'dine${i}Url';
          final amenityValue = datas[amenity];
          final amenityUrlValue = datas[amenityUrl];
          if (amenityValue != null && amenityUrlValue != null) {
            final getters = await getter(amenityUrlValue);
            datas['dine$i'] = amenityValue;
            datas['dine${i}Url'] = getters;
          }
        }
        var text = datas['beach_name'];
        var image = datas['image'];
        var located = datas['beach_located'];
        final imageUrl = await getter(image);
        datas['image'] = imageUrl;
        datas['beach_name'] = text;
        datas['beach_located'] = located;
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
}
