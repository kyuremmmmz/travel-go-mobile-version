import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Vouchers {
  final supabase = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> getTheDiscountsAsList(String uid) async {
    final response = await supabase.from('discounts').select('*').eq('uid', uid);
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
        final claimed = datas['claimed'];
        datas['hotelName'] = hotelName;
        datas['discount'] = discount;
        datas['expiry'] = expiry;
        datas['ishotel'] = isHotel;
        datas['claimed'] = claimed;
      }
      return result;
    }
  }

  Future<List<Map<String, dynamic>>> getTheDiscountsAsListOfLikeReal(
      List<Map<String, dynamic>> nameList, String? hotelName) async {
    final hotelNames = nameList.map((name) => name['hotelName'].toString()).toList();

    if (hotelNames.isEmpty) {
      return [];
    }

    final response = await supabase
        .from('discounts')
        .select('*')
        .ilike('hotelName', '%$hotelName%');
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


  Future<List<Map<String, dynamic>>> getTheDiscountsAsListOfLike(
      String nameList) async {
    final response =
        await supabase.from('discounts').select('*').eq('hotelName', nameList);
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
  
  Future<Map<String, dynamic>?> insertRandomlyThevouchers() async {
    final uid = supabase.auth.currentUser!.id;
    final today = DateTime.now();
    final todayDateString =
        DateTime(today.year, today.month, today.day).toIso8601String();
    final response = await supabase.from('hotels').select('hotel_name');
    final voucherGivenTodayResponse = await supabase
        .from('discounts')
        .select()
        .eq('uid', uid)
        .gte(
            'created_at', todayDateString) // Check if voucher was created today
        .limit(1);
    if (response.isEmpty) {
      throw Exception('Error fetching data');
    }

    if (voucherGivenTodayResponse.isNotEmpty) {
      const SnackBar(content:  Text(
        'Voucher given today'
      ));
    }

    final random = Random();
    final index = random.nextInt(response.length);
    final randomHotelName = response[index]['hotel_name'];

    final insertion = await supabase.from('discounts').insert({
      'uid': uid,
      'ishotel': true,
      'hotelName': randomHotelName,
      'discount': 10 + random.nextInt(41), 
      'expiry': DateTime.now().add(const Duration(days: 30)).toIso8601String(), 
      'claimed': 'not claimed',
    });
    return insertion;
  }

  Future<void> deleteDiscount(int id) async {
    return await supabase.from('discounts').delete().eq('id', id);
  }
}
