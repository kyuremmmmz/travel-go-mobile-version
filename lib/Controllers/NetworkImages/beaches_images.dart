import 'package:supabase_flutter/supabase_flutter.dart';

class BeachesImages {
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

  Future<Map<String, dynamic>?> fetchDataInSingle(int id) async {
    try {
      final response =
          await supabase.from('beaches').select('*').eq('id', id).single();

      if (response.isEmpty) {
        print('beach not found');
        return null;
      } else {
        var map = response;
        var place = map['beach_name'];
        var image = map['image'];
        var amenity1 = map['amenity1'];
        var amenity2 = map['amenity2'];
        var amenity3 = map['amenity3'];
        var amenity4 = map['amenity4'];
        var amenity5 = map['amenity5'];
        var amenity6 = map['amenity6'];
        var amenity7 = map['amenity7'];
        var amenity8 = map['amenity8'];
        var amenity9 = map['amenity9'];
        var amenity10 = map['amenity10'];
        var amenity11 = map['amenity11'];
        var amenity12 = map['amenity12'];
        var amenity13 = map['amenity13'];
        var amenity14 = map['amenity14'];
        var amenity15 = map['amenity15'];
        var amenity16 = map['amenity16'];
        var amenity17 = map['amenity17'];
        var amenity18 = map['amenity18'];
        var amenity19 = map['amenity19'];
        var amenity20 = map['amenity20'];
        map['amenity1'] = amenity1;
        map['amenity2'] = amenity2;
        map['amenity3'] = amenity3;
        map['amenity4'] = amenity4;
        map['amenity5'] = amenity5;
        map['amenity6'] = amenity6;
        map['amenity7'] = amenity7;
        map['amenity8'] = amenity8;
        map['amenity9'] = amenity9;
        map['amenity10'] = amenity10;
        map['amenity11'] = amenity11;
        map['amenity12'] = amenity12;
        map['amenity13'] = amenity13;
        map['amenity14'] = amenity14;
        map['amenity15'] = amenity15;
        map['amenity16'] = amenity16;
        map['amenity17'] = amenity17;
        map['amenity18'] = amenity18;
        map['amenity19'] = amenity19;
        map['amenity20'] = amenity20;

        var imageUrl = await getter(image);
        map['image'] = imageUrl;
        map['beach_name'] = place;
        return map;
      }
    } catch (e) {
      print('Error fetching beach data: $e');
      return null;
    }
  }
}
