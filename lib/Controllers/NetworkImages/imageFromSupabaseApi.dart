import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Routes/Routes.dart';

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

  Future<void> fetchSpecificDataInSingle(BuildContext context, String name) async {
    final responses = await supabase
        .from('places')
        .select('*')
        .eq('place_name', name)
        .single();
    if (responses.isEmpty) {
      print('Error fetching data: ${responses.toString()}');
    } else {
      final datas = responses;
      var text = datas['place_name'];
      var image = datas['image'];
      var description = datas['description'];
      var price = datas['price'];
      final imageUrl = await getter(image);
      datas['image_url'] = imageUrl;
      print(image);
      print(text);
      print(imageUrl);
      print(description);
      print(price);
      // ignore: use_build_context_synchronously
      AppRoutes.navigateToInformationalScreen(context);
    }
  }
}
