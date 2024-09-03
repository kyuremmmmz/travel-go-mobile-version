import 'package:supabase_flutter/supabase_flutter.dart';

class Data {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchImageandText() async {
    final response = await supabase.from('places').select('*');

    if (response.isEmpty) {
      print('Error fetching data: ${response.toString()}');
      return [];
    }

    List<Map<String, dynamic>> places =
        List<Map<String, dynamic>>.from(response as List);
    for (var place in places) {
      var text = place['place_name'];
      var image = place['image'];
      final imageUrl = await getter(image);
      place['image_url'] = imageUrl;
      print(image);
      print(text);
      print(imageUrl);
    }

    return places;
  }

  Future<String> getter(String imageUrl) async {
    try {
      final response =
          supabase.storage.from('places_url').getPublicUrl(imageUrl);
      if (response.isEmpty) {
        return 'Null';
      }
      return response;
    } catch (e) {
      print('Error getting image URL: $e');
      return 'Error';
    }
  }
}
