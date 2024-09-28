import 'package:supabase_flutter/supabase_flutter.dart';

class Festivalslist {
  final supabase = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> listOfFestivals() async {
    final response = await supabase.from('Festivals').select('*');

    if (response.isEmpty) {
      return [];
    } else {
      final data = response;

      List<Map<String, dynamic>> res =
          List<Map<String, dynamic>>.from(data as List);
      for (var data in res) {
        var img = data['img'];
        var imgUrl = data['imgUrl'];
        var get = await getter(imgUrl);
        data['img'] = img;
        data['imgUrl'] = get;
      }
      return data;
    }
  }

  Future<String?> getter(String get) async {
    final res = supabase.storage.from('Festivals').getPublicUrl(get);
    if (res.isEmpty) {
      return 'null';
    }
    return res;
  }
}
