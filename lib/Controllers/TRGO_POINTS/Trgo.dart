import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Trgo {
  final supabase = Supabase.instance.client;

  Future<PostgrestList?> trgoPoints(BuildContext context) async {
    try {
      final user = supabase.auth.currentUser!.id;
      double pointsToAdd = 0.02;

      final query = await supabase
          .from('TRGO_POINTS')
          .select('points')
          .eq('uid', user)
          .maybeSingle();

      double currentPoints =
          (query != null && query['points'] != null) ? query['points'] : 0.0;

      if (currentPoints >= 1.0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You have reached the maximum points limit. Current points: $currentPoints',
            ),
          ),
        );
        return null;
      } else {
        double updatedPoints = (currentPoints + pointsToAdd) > 1.0
            ? 1.0
            : currentPoints + pointsToAdd;

        final response = await supabase
            .from('TRGO_POINTS')
            .update({
              'points': updatedPoints,
            })
            .eq('uid', user)
            .select();

        if (response != null && response.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Points added successfully! Current points: $updatedPoints',
            ),
          ));
          return response;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to update points. Please try again.'),
          ));
          return null;
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
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

  Future<Map<String, dynamic>?> fetchMoney() async {
    try {
      final user = supabase.auth.currentUser!.id;
      final query = await supabase
          .from('TRGO_POINTS')
          .select('money')
          .eq('uid', user)
          .maybeSingle();
      if (query == null || query['money'] == null) {
        return null;
      } else {
        final result = query;
        final money = result['money'];
        result['money'] = money;
        return result;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> updatePointsToMoney(
      BuildContext context) async {
    try {
      final user = supabase.auth.currentUser!.id;
      final query = await supabase
          .from('TRGO_POINTS')
          .select('money, points')
          .eq('uid', user)
          .maybeSingle();
      if (query == null || query['points'] == null) {
        return null;
      } else {
        final data = double.parse(query['points'].toString());
        if (data == 1.0) {
          final response = await supabase.from('TRGO_POINTS').update({
            'uid': user,
            'points': 0.01,
            'money': 1000,
          }).eq('uid', user);
          return response;
        }
        return null;
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
}
