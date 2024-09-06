import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itransit/Widgets/Screens/App/information.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class Data {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchImageandText() async {
    final response = await supabase.from('places').select('*');

    if (response.isEmpty) {
      print('Error fetching data: ${response.toString()}');
      return [];
    } else {
      List<Map<String, dynamic>> places =
          List<Map<String, dynamic>>.from(response as List);
      for (var place in places) {
        var text = place['place_name'];
        var image = place['image'];
        final imageUrl = await getter(image);
        place['image_url'] = imageUrl;
        place['place_name'] = text;
      }
      return places;
    }
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

  Future<Map<String, dynamic>?> fetchSpecificDataInSingle(int id) async {
    try {
      final response =
          await supabase.from('places').select('*').eq('id', id).single();

      if (response.isNotEmpty) {
        final datas = response;
        var text = datas['place_name'];
        var image = datas['image'];
        var cars = datas['car_availability'];
        var tricycleAvailability = datas['tricycle_availability'];
        var located = datas['locatedIn'];
        var price = datas['price'];
        var priceQ = NumberFormat('#,###');
        final formattedPrice = priceQ.format(price);
        final imageUrl = await getter(image);
        datas['image'] = imageUrl;
        datas['place_name'] = text;
        datas['car_availability'] = cars;
        datas['tricycle_availability'] = tricycleAvailability;
        datas['locatedIn'] = located;
        datas['price'] = formattedPrice;
        print(cars);
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

  Future<Map<String, dynamic>?> fetchinSearch(
      String name, BuildContext context) async {
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
        var price = datas['price'];
        var id = datas['id'];
        var priceQ = NumberFormat('#,###');
        final formattedPrice = priceQ.format(price);
        final imageUrl = await getter(image);
        datas['image'] = imageUrl;
        datas['place_name'] = text;
        datas['car_availability'] = cars;
        datas['tricycle_availability'] = tricycleAvailability;
        datas['locatedIn'] = located;
        datas['id'] = id;
        datas['price'] = formattedPrice;
        Navigator.push(context,MaterialPageRoute(
                builder: (context) => 
                InformationScreen(
                      text: id,
                      name: text,
                    )
                  )
                );
                return datas;
      } else {
        print('No data found for $name');
        return null;
      }
    } catch (e) {
      print('Error fetching data in search: $e');
      return null;
    }
  }
}
