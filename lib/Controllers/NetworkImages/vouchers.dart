import 'dart:math'; // Importing dart:math for random number generation.

import 'package:flutter/material.dart'; // Importing Flutter's material design package for UI components.
import 'package:supabase_flutter/supabase_flutter.dart'; // Importing Supabase Flutter package for database operations.

class Vouchers {
  final supabase = Supabase.instance.client; // Method to fetch a list of discounts based on a user ID (uid).

  Future<List<Map<String, dynamic>>> getTheDiscountsAsList(String uid) async {
    final response = await supabase.from('discounts').select('*').eq('uid', uid);   // Query the 'discounts' table for records that match the given uid.

    
    if (response.isEmpty) {
      return []; // If no matching records are found, return an empty list.
    } else { 
      final data = response;   // Store the query response data.

      List<Map<String, dynamic>> result =  // Convert the response data to a List of Maps.
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in result) { // Retain only necessary fields in each discount entry.
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
      return result; // Return the list of discount entries.
    }
  }
  // Method to update the status of a voucher to 'claimed' based on the voucher ID.
  Future<Map<String, dynamic>?> updateVoucherToclaim(int id) async { // Update the 'claimed' field to 'claimed' for the voucher with the specified ID.
    final response = await supabase // Update the 'claimed' field to 'claimed' for the voucher with the specified ID.
        .from('discounts')
        .update({'claimed': 'claimed'}).eq('id', id); 
    return response; // Return the response from the update operation.
  }
  // Method to retrieve a list of discounts filtered by similar hotel names.
  Future<List<Map<String, dynamic>>> getTheDiscountsAsListOfLikeReal(
      List<Map<String, dynamic>> nameList, String? hotelName) async {
    final hotelNames =
        nameList.map((name) => name['hotelName'].toString()).toList();

    if (hotelNames.isEmpty) {
      return []; // Return an empty list if no hotel names are provided.
    }
    // Query the 'discounts' table for records with similar hotel names.
    final response = await supabase
        .from('discounts')
        .select('*')
        .ilike('hotelName', '%$hotelName%');
    if (response.isEmpty) {
      return []; // Return an empty list if no matching records are found.
    } else {
      List<Map<String, dynamic>> result =
          List<Map<String, dynamic>>.from(response as List); 

      // Retain only necessary fields in each discount entry.
      for (var datas in result) {
        datas['hotelName'] = datas['hotelName'];
        datas['discount'] = datas['discount'];
        datas['expiry'] = datas['expiry'];
        datas['ishotel'] = datas['ishotel'];
      }
      return result; // Return the filtered list of discount entries.
    }
  }
   // Method to retrieve a list of discounts filtered by exact hotel name matches.
  Future<List<Map<String, dynamic>>> getTheDiscountsAsListOfLike(
      String nameList) async {
    final response =
        await supabase.from('discounts').select('*').eq('hotelName', nameList);
    if (response.isEmpty) { 
      return []; // Return an empty list if no matching records are found.
    } else {
      List<Map<String, dynamic>> result =
          List<Map<String, dynamic>>.from(response as List);

      // Retain only necessary fields in each discount entry.
      for (var datas in result) {
        datas['hotelName'] = datas['hotelName'];
        datas['discount'] = datas['discount'];
        datas['expiry'] = datas['expiry'];
        datas['ishotel'] = datas['ishotel'];
      }
      return result; // Return the list of matching discount entries.
    }
  }

   // Method to insert a randomly selected voucher for the current user.
  Future<Map<String, dynamic>?> insertRandomlyThevouchers() async {
    final uid = supabase.auth.currentUser!.id;
    final today = DateTime.now();
    final todayDateString =
        DateTime(today.year, today.month, today.day).toIso8601String(); // Format today's date.
    final response = await supabase.from('hotels').select('hotel_name');

    //THIS Check if a voucher was already given today to avoid duplication.
    final voucherGivenTodayResponse = await supabase
        .from('discounts')
        .select()
        .eq('uid', uid)
        .gte('created_at', todayDateString) // Check if voucher was created today
        .limit(1);

    if (response.isEmpty) {
      throw Exception('Error fetching data'); // This throw an error message if no hotels are found. 
    }

    if (voucherGivenTodayResponse.isNotEmpty) {
      const SnackBar(content: Text('Voucher given today')); // this display a message of a vouvher was already given today 
    }

    final random = Random(); // for random numbers 
    final index = random.nextInt(response.length); // random index within the hotel list 
    final randomHotelName = response[index]['hotel_name']; // select a random hotel name from the list 

    // Insert a new voucher with the random hotel name and a random discount percentage.
    final insertion = await supabase.from('discounts').insert({
      'uid': uid,
      'ishotel': true,
      'hotelName': randomHotelName,
      'discount': 10 + random.nextInt(41), // Random discount between 10% and 50%.
      'expiry': DateTime.now().add(const Duration(days: 30)).toIso8601String(), // Expiry date set to 30 days from today.
      'claimed': 'not claimed',
    });
    return insertion; // Return the insertion result.
  }
  // Method to delete a discount record by its ID.
  Future<void> deleteDiscount(int id) async {
    return await supabase.from('discounts').delete().eq('id', id);
  }
}
