import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Booking {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> passTheDate(int id) async {
    final response =
        await supabase.from('flightsList').select('*').eq('id', id).single();
    if (response.isEmpty) {
      return null;
    } else {
      final data = response;
      final origin = data['airplane'];
      final airport = data['airport'];
      final destination = data['place'];
      final price = data['price'];
      final departure = data['departure'];

      DateTime now = DateTime.now();
      String cleanTimeString = departure.split('+')[0];
      DateTime dateFormat = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(cleanTimeString.split(':')[0]),
          int.parse(cleanTimeString.split(':')[1]),
          int.parse(cleanTimeString.split(':')[2]));
      var formatTime = DateFormat.jm().format(dateFormat);

      data['price'] = price;
      data['airplane'] = origin;
      data['airport'] = airport;
      data['place'] = destination;
      data['departure'] = formatTime;
      return data;
    }
  }

  Future<PostgrestResponse?> flightBooking(
    int id,
    String firstName,
    String lastName,
    String country,
    String phoneNumber,
    String email,
    String origin,
    String returnDate,
    String departureDate,
    String destination,
    int payment,
    String paymentMethod,
    String plane,
    String airPort,
    String travelType,
  ) async {
    return null;
  }
}
