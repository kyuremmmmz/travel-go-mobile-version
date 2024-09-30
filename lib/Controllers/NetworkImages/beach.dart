import 'package:supabase_flutter/supabase_flutter.dart';

class Beach {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> beachesList() async {
    final response = await supabase.from('Beaches').select('*');
    try {
      if (response.isEmpty) {
        return [];
      } else {
        final data = response;

        List<Map<String, dynamic>> result =
            List<Map<String, dynamic>>.from(data as List);
        for (var datas in result) {
          var name = datas['img'];
          var imgUrl = datas['imgUrl'];
          var imgFinal = await getter(imgUrl);
          datas['imgUrl'] = imgFinal;
          datas['img'] = name;
        }
        return data;
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String?> getter(String name) async {
    final storage = supabase.storage.from('beaches').getPublicUrl(name);
    return storage;
  }
}
