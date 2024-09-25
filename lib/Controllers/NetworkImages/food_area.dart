import 'package:supabase_flutter/supabase_flutter.dart';

class FoodAreaBackEnd {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getFood() async {
    final response = await supabase.from('food_area').select();

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

  Future<String?> getter(String image) async {
    final response = supabase.storage.from('food_area').getPublicUrl(image);
    if (response.isEmpty) {
      return 'null';
    }
    return response;
  }
}
