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
      final response = await supabase.from('TRGO_POINTS').update({
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

  Future<Map<String, dynamic>?> createPoints(BuildContext context) async {
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
      final response = await supabase.from('TRGO_POINTS').insert({
        'uid': user,
        'points': updatedPoints,
        'money': 0,
      });

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

  Future<Map<String, dynamic>?> updatePointsToMoney(
      BuildContext context) async {
    try {
      final user = supabase.auth.currentUser!.id;
      final query = await supabase
          .from('TRGO_POINTS')
          .select('points')
          .eq('uid', user)
          .maybeSingle();
      if (query == null) {
        return null;
      } else {
        final data = query;
        if (data.containsValue(1.0)) {
          final response = await supabase.from('TRGO_POINTS').update({
            'uid': user,
            'points': 0.01,
            'money': 1000,
          }).eq('uid', user);
          return response;
        }
        return data;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e'),
      ));
      return null;
    }
  }

  Future<Map<String, dynamic>?> getThePointsOfMine() async {
    final user = supabase.auth.currentUser!.id;
    final response = await supabase
        .from('TRGO_POINTS')
        .select('points')
        .eq('uid', user)
        .single();
    if (response.isEmpty) {
      return null;
    } else {
      final data = response;
      final points = data['points'];
      data['points'] = points;
      return data;
    }
  }

  Future<Map<String, dynamic>?> spendPoints(BuildContext context) async {
    try {
      final user = supabase.auth.currentUser!.id;
      double spendPoints = 1.0;
      final query = await supabase
          .from('TRGO_POINTS')
          .select('points')
          .eq('uid', user)
          .maybeSingle();
      double currentPoints =
          (query != null && query['points'] != null) ? query['points'] : 0;
      double updatedPoints = currentPoints - spendPoints;
      double roundOffPoints = double.parse(updatedPoints.toStringAsFixed(2));

      final response = await supabase
          .from('TRGO_POINTS')
          .update({'points': roundOffPoints}).eq('uid', user);

      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Points updated successfully! Current points: $roundOffPoints',
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
}
