import 'package:supabase_flutter/supabase_flutter.dart';

class Data {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchImageandText() async {
    final response = await supabase.from('places').select('*');

    if (response.isEmpty) {
      print('Error fetching data: ${response.toString()}');
      return [];
    }

    List<Map<String, dynamic>> places = List<Map<String, dynamic>>.from(response as List);
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

  Future<Map<String, dynamic>?> fetchSpecificDataInSingle(String name) async {
    try {
      final response = await supabase
          .from('places')
          .select('*')
          .eq('place_name', name)
          .single();

      if (response.isNotEmpty) {
        final datas = response;
        var text = datas['place_name'];
        var image = datas['image'];
        var cars = datas['car_availability'];
        var tricycleAvailability = datas['tricycle_availability'];
        var located = datas['locatedIn'];
        var availability = datas['availability'];
        final imageUrl = await getter(image);
        datas['image_url'] = imageUrl;
        print(cars);
        return {
          'place_name': text,
          'description': datas['description'] ?? 'No description available',
          'image': imageUrl,
          'car_availability': cars,
          'tricycle_availability': tricycleAvailability,
          'locatedIn' : located,
          'availability' : availability
        };
      } else {
        print('No data found for $name');
        return null;
      }
    } catch (e) {
      print('Error fetching specific data: $e');
      return null;
    }
  }
}
