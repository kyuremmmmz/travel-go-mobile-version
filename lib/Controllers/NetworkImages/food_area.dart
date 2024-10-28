import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodAreaBackEnd {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getFood() async {
    final response = await supabase.from('food_area').select('*');

    if (response.isEmpty) {
      return [];
    } else {
      final data = response;
      List<Map<String, dynamic>> list =
          List<Map<String, dynamic>>.from(data as List);
      for (var data in list) {
        var img = data['imgUrl'];
        final imageUrl = await getter(img);
        var text = data['img'];
        data['imgUrl'] = imageUrl;
        data['img'] = text;
      }
      return list;
    }
  }

  Future<List<Map<String, dynamic>>> fetchFoodAreaByplace(
      String located) async {
    try {
      final response =
          await supabase.from('food_area').select('*').eq('located', located);
      if (response.isEmpty) {
        debugPrint('no food area found');
        return [];
      } else {
        final data = response;

        List<Map<String, dynamic>> map =
            List<Map<String, dynamic>>.from(data as List);
        for (var map in data) {
          var place = map['img'];
          var image = map['imgUrl'];
          var imageUrl = await getter(image);
          map['imgUrl'] = imageUrl;
          map['img'] = place;
        }
        return map;
      }
    } catch (e) {
      debugPrint('Error fetching food area: $e');
      return [];
    }
  }

  Future<String?> getter(String image) async {
    final response = supabase.storage.from('food_area').getPublicUrl(image);
    if (response.isEmpty) {
      return 'null';
    }
    return response;
  }

  Future<Map<String, dynamic>?> getSpecificData(int id) async {
    final response =
        await supabase.from('food_area').select("*").eq('id', id).single();
    if (response.isEmpty) {
      return null;
    } else {
      final data = response;
      for (var i = 1; i <= 20; i++) {
        final dineT = "dine$i";
        final dineImg = "dineUrl$i";
        final img = data[dineT];
        final imgUrl = data[dineImg];
        if (img != null || imgUrl != null) {
          final get = await getter(imgUrl);
          data['dine$i'] = img;
          data['dineUrl$i'] = get;
        }
      }
      var img = data['imgUrl'];
      final imageUrl = await getter(img);
      var text = data['img'];
      var menu = data['menu'];
      var price = data['price'];
      var located = data['located'];
      var description = data['description'];
      data['description'] = description;
      data['price'] = price;
      data['imgUrl'] = imageUrl;
      data['located'] = located;
      data['img'] = text;
      data['menu'] = menu;
      return data;
    }
  }
}
