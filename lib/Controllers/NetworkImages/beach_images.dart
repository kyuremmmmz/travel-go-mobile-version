import 'package:flutter/material.dart'; // Import Flutter material design package
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase Flutter package

class BeachImages {
  final supabase = Supabase.instance.client;  // Initialize Supabase client

  // Fetch a list of beaches from the Supabase database
  Future<List<Map<String, dynamic>>> fetchBeaches() async {
    final response = await supabase.from('Beaches').select('*'); // Make a request to the 'Beaches' table to select all records
    try { 
      if (response.isEmpty) { // Check if the response is empty
        return []; // Return an empty list if there are no records
      } else {
        final data = response; // Store the fetched data
        List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(data as List);  // Convert the list of dynamic data to a list of maps
        for (var datas in result) {  // Iterate over each beach data in the result list
          var name = datas['beach_name'];
          var imgUrl = datas['image'];
          var imgFinal = await getter(imgUrl);
          datas['image'] = imgFinal;
          datas['beach_name'] = name;
        }
        return data; // Return the updated list of beaches
      }
    } catch (e) {
      debugPrint('$e');  // Log any errors that occur
      return []; // Return an empty list on error
    }
  }

  Future<String?> getter(String name) async { // this Fetch a public URL for a given image name from Supabase storage
    final storage = supabase.storage.from('beaches').getPublicUrl(name); // this get the public url for the specifies image
    return storage; // return the public URL 
  }

  // Fetch a public URL for a given image name from Supabase storage
  Future<Map<String, dynamic>?> getSpecificData(int id) async {
    try {
      final response =
          await supabase.from('Beaches').select('*').eq('id', id).single();
      // Check if the response contains data
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
            datas['dine${i}Url'] = getters; // Update the amenity URL with its public URL
          }
        }
        var text = datas['beach_name'];
        var image = datas['image'];
        var located = datas['beach_located'];
        final imageUrl = await getter(image);
        datas['image'] = imageUrl;
        datas['beach_name'] = text;
        datas['beach_located'] = located;
        return datas; // Return the updated beach data
      } else {
        debugPrint('No data found for $id');  // Log a message if no data found
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching specific data: $e'); // Log any errors that occur
      return null;
    }
  }
}
