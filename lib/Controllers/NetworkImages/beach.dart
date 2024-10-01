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
          var name = datas['beach_name'];
          var imgUrl = datas['image'];
          var imgFinal = await getter(imgUrl);
          datas['image'] = imgFinal;
          datas['beach_name'] = name;
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
