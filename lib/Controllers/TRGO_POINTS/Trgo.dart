import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Trgo {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> trgoPoints(BuildContext context) async {
    try {
      final user = supabase.auth.currentUser!.id;
      double points = 0.02;
      final query = await supabase
          .from('TRGO_POINTS')
          .select('points')
          .eq('uid', user)
          .maybeSingle();
      double currentPoints =
          (query != null && query['points'] != null) ? query['points'] : 0;
      double updatedPoints = currentPoints + points;
      final response = await supabase.from('TRGO_POINTS').upsert({
        'uid': user,
        'points': updatedPoints,
        'money': 0,
      }).eq('uid', user);

      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Points added successfully! Current points: $points',
          ),
        ));
        return response;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e'),
      ));
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getThePointsOfMine() async {
    final user = supabase.auth.currentUser!.id;
    final response =
        await supabase.from('TRGO_POINTS').select('*').eq('uid', user);
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;

      List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(data as List);
      for (var datas in result) {
        final points =  datas['points'];
        datas['points'] = points;
      }
      return result;
    }
  }
}
