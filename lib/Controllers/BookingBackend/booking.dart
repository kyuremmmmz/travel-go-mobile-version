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
      final arrival = data['arrival'];
      final departureDate = data['date'];
      final arrivalDate = data['date_departure'];
      final returndate = data['return_date'];
      final returnTime = data['return'];
      DateTime dateFormatIto = DateTime.parse(departureDate);
      var formatDateIto = DateFormat('MMM d').format(dateFormatIto);

      DateTime returnDateFormatIto = DateTime.parse(returndate);
      var returnformatDateIto = DateFormat('MMM d').format(returnDateFormatIto);

      DateTime arrivaldateFormatIto = DateTime.parse(arrivalDate);
      var arrivalformatDateIto =
          DateFormat('MMM d').format(arrivaldateFormatIto);

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

      String returncleanTimeString = returnTime.split('+')[0];
      DateTime returndateFormat = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(returncleanTimeString.split(':')[0]),
          int.parse(returncleanTimeString.split(':')[1]),
          int.parse(returncleanTimeString.split(':')[2]));
      var returnformatTime = DateFormat.jm().format(returndateFormat);

      String arrivalTimeString = arrival.split('+')[0];
      DateTime arrivaldateFormat = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(arrivalTimeString.split(':')[0]),
          int.parse(arrivalTimeString.split(':')[1]),
          int.parse(arrivalTimeString.split(':')[2]));
      var arrivalformatTime = DateFormat.jm().format(arrivaldateFormat);

      data['arrival'] = arrivalformatTime;
      data['price'] = price;
      data['airplane'] = origin;
      data['airport'] = airport;
      data['place'] = destination;
      data['departure'] = formatTime;
      data['date'] = formatDateIto;
      data['date_departure'] = arrivalformatDateIto;
      data['return_date'] = returnformatDateIto;
      data['return'] = returnformatTime;
      return data;
    }
  }

  Future<PostgrestResponse?> flightBooking(
    String firstName,
    String lastName,
    String country,
    int phoneNumber,
    int age,
    String email,
    String origin,
    String returnDate,
    String departureDate,
    String departureTime,
    String arrivalTime,
    String arrivalDate,
    String destination,
    int payment,
    String paymentMethod,
    String plane,
    String airPort,
    String travelType,
    String bookingId
  ) async {
    final response = await supabase.from('flightBooking').insert({
      'firstName': firstName,
      'lastName': lastName,
      'country': country,
      'phoneNumber': phoneNumber,
      'email': email,
      'origin': origin,
      'destination': destination,
      'age': age,
      'departureDate': departureDate,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'arrival_date': arrivalDate,
      'returnDate': returnDate,
      'payment': payment,
      'paymentMethod': paymentMethod,
      'plane': plane,
      'airPort': airPort,
      'traveltype': travelType,
      'booking_id' : bookingId
    });
    if (response != null) {
      return response;
    }else{
      return null;
    }
  }
}
