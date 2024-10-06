import 'package:supabase_flutter/supabase_flutter.dart';

class FestivalsImages {
  final supabase = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> fetchFestivals() async {
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

  Future<PostgrestMap?> getSpecificData(int id) async {
    final res =
        await supabase.from('Festivals').select('*').eq('id', id).single();
    if (res.isEmpty) {
      return null;
    } else {
      final data = res;
      var img = data['img'];
      var imgUrl = data['imgUrl'];
      var located = data['Located'];
      var tips = data['TipsForVisitors'];
      var get = await getter(imgUrl);
      for (var i = 0; i < 20; i++) {
        var text = 'Dine$i';
        var text2 = data[text];
        var imgUrlDine = data['DineUrl$i'];
        if (text.isNotEmpty && imgUrlDine != null) {
          final gett = await getter(imgUrlDine);
          data[text] = text2;
          data['DineUrl$i'] = gett;
        }
        data['img'] = img;
        data['TipsForVisitors'] = tips;
        data['imgUrl'] = get;
        data['Located'] = located;
      }
      return data;
    }
  }
}
