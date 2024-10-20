import 'package:supabase_flutter/supabase_flutter.dart';

class Vouchers {
  final supabase = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> getTheDiscountsAsList() async {
    final response = await supabase.from('discounts').select('*');
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;

      List<Map<String, dynamic>> result =
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in result) {
        final hotelName = datas['hotelName'];
        final discount = datas['discount'];
        final expiry = datas['expiry'];
        final isHotel = datas['ishotel'];
        datas['hotelName'] = hotelName;
        datas['discount'] = discount;
        datas['expiry'] = expiry;
        datas['ishotel'] = isHotel;
      }
      return result;
    }
  }

  Future<List<Map<String, dynamic>>> getTheDiscountsAsListOfLike(
      List<Map<String, dynamic>> nameList) async {
    final hotelNames = nameList.map((name) => name['hotelName'].toString()).toList();

    if (hotelNames.isEmpty) {
      return [];
    }

    final response = await supabase
        .from('discounts')
        .select('*')
        .ilike('hotelName', '%${hotelNames.first}%');

    if (response.isEmpty) {
      return [];
    } else {
      List<Map<String, dynamic>> result =
          List<Map<String, dynamic>>.from(response as List);

      for (var datas in result) {
        datas['hotelName'] = datas['hotelName'];
        datas['discount'] = datas['discount'];
        datas['expiry'] = datas['expiry'];
        datas['ishotel'] = datas['ishotel'];
      }
      return result;
    }
  }


  Future<void> deleteDiscount(int id) async {
    return await supabase.from('discounts').delete().eq('id', id);
  }
}
