import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Flightsbackend {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> flightList() async {
    final response = await supabase
        .from('flightsList')
        .select('*')
        .eq('ticket_type', 'cheapest');
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;
      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in results) {
        var img = datas['airplane_img'];
        var name = datas['airport'];
        var pricePlace = datas['price'];
        var price = NumberFormat('#,###');
        var departure = datas['departure'];
        var arrival = datas['arrival'];
        var returnD = datas['return'];
        var returnArrival = datas['return_arrival'];
        var cleanTimeToString = returnD.split('+')[0];
        DateTime now = DateTime.now();
        DateTime dateFormatTo = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeToString.split(':')[0]),
            int.parse(cleanTimeToString.split(':')[1]),
            int.parse(cleanTimeToString.split(':')[2]));
        var formatTimeHe = DateFormat.jm().format(dateFormatTo);

        var cleanThis = returnArrival.split('+')[0];
        DateTime dateFormatreturn = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanThis.split(':')[0]),
            int.parse(cleanThis.split(':')[1]),
            int.parse(cleanThis.split(':')[2]));
        var formatTimeReturn = DateFormat.jm().format(dateFormatreturn);

        var cleanTimeToWhat = arrival.split('+')[0];
        DateTime dateFormathehe = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeToWhat.split(':')[0]),
            int.parse(cleanTimeToWhat.split(':')[1]),
            int.parse(cleanTimeToWhat.split(':')[2]));
        var formatTimeyan = DateFormat.jm().format(dateFormathehe);

        String cleanTimeString = departure.split('+')[0];
        DateTime dateFormat = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeString.split(':')[0]),
            int.parse(cleanTimeString.split(':')[1]),
            int.parse(cleanTimeString.split(':')[2]));
        var formatTime = DateFormat.jm().format(dateFormat);
        var format = price.format(pricePlace);
        var nameOfDeparture = datas['airplane'];

        var departureDate = datas['date_departure'];
        DateTime dateFormatDeparture = DateTime.parse(departureDate);
        var formatDateDeparture =
            DateFormat('MMM d').format(dateFormatDeparture);

        var date = datas['date'];
        DateTime dateFormatIto = DateTime.parse(date);
        var formatDateIto = DateFormat('MMM d').format(dateFormatIto);

        var dateArrival = datas['date_arrival'];
        DateTime dateFormatArrival = DateTime.parse(dateArrival);
        var formatDateArrival = DateFormat('MMM d').format(dateFormatArrival);

        var returnDate = datas['return_date'];
        DateTime dateReturnArrival = DateTime.parse(returnDate);
        var formatDateReturnArrival =
            DateFormat('MMM d').format(dateReturnArrival);

        datas['date_departure'] = formatDateDeparture;
        datas['date_arrival'] = formatDateArrival;
        datas['return_date'] = formatDateReturnArrival;
        datas['airplane'] = nameOfDeparture;
        datas['airport'] = name;
        datas['date'] = formatDateIto;
        datas['return_arrival'] = formatTimeReturn;
        datas['return'] = formatTimeHe;
        datas['arrival'] = formatTimeyan;
        datas['departure'] = formatTime;
        datas['price'] = format;
        var imgUrl = await getter(img);
        datas['airplane_img'] = imgUrl;
      }
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> flightListBest() async {
    final response = await supabase
        .from('flightsList')
        .select('*')
        .eq('ticket_type', 'best');
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;
      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in results) {
        var id = datas['id'];
        var img = datas['airplane_img'];
        var name = datas['airport'];
        var pricePlace = datas['price'];
        var price = NumberFormat('#,###');
        var departure = datas['departure'];
        var arrival = datas['arrival'];
        var returnD = datas['return'];
        var returnArrival = datas['return_arrival'];
        var cleanTimeToString = returnD.split('+')[0];
        DateTime now = DateTime.now();
        DateTime dateFormatTo = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeToString.split(':')[0]),
            int.parse(cleanTimeToString.split(':')[1]),
            int.parse(cleanTimeToString.split(':')[2]));
        var formatTimeHe = DateFormat.jm().format(dateFormatTo);

        var cleanThis = returnArrival.split('+')[0];
        DateTime dateFormatreturn = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanThis.split(':')[0]),
            int.parse(cleanThis.split(':')[1]),
            int.parse(cleanThis.split(':')[2]));
        var formatTimeReturn = DateFormat.jm().format(dateFormatreturn);

        var cleanTimeToWhat = arrival.split('+')[0];
        DateTime dateFormathehe = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeToWhat.split(':')[0]),
            int.parse(cleanTimeToWhat.split(':')[1]),
            int.parse(cleanTimeToWhat.split(':')[2]));
        var formatTimeyan = DateFormat.jm().format(dateFormathehe);

        String cleanTimeString = departure.split('+')[0];
        DateTime dateFormat = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeString.split(':')[0]),
            int.parse(cleanTimeString.split(':')[1]),
            int.parse(cleanTimeString.split(':')[2]));
        var formatTime = DateFormat.jm().format(dateFormat);
        var format = price.format(pricePlace);
        var nameOfDeparture = datas['airplane'];

        var departureDate = datas['date_departure'];
        DateTime dateFormatDeparture = DateTime.parse(departureDate);
        var formatDateDeparture =
            DateFormat('MMM d').format(dateFormatDeparture);

        var date = datas['date'];
        DateTime dateFormatIto = DateTime.parse(date);
        var formatDateIto = DateFormat('MMM d').format(dateFormatIto);

        var dateArrival = datas['date_arrival'];
        DateTime dateFormatArrival = DateTime.parse(dateArrival);
        var formatDateArrival = DateFormat('MMM d').format(dateFormatArrival);

        var returnDate = datas['return_date'];
        DateTime dateReturnArrival = DateTime.parse(returnDate);
        var formatDateReturnArrival =
            DateFormat('MMM d').format(dateReturnArrival);
        datas['id'] = id;
        datas['date_departure'] = formatDateDeparture;
        datas['date_arrival'] = formatDateArrival;
        datas['return_date'] = formatDateReturnArrival;
        datas['airplane'] = nameOfDeparture;
        datas['airport'] = name;
        datas['date'] = formatDateIto;
        datas['return_arrival'] = formatTimeReturn;
        datas['return'] = formatTimeHe;
        datas['arrival'] = formatTimeyan;
        datas['departure'] = formatTime;
        datas['price'] = format;
        var imgUrl = await getter(img);
        datas['airplane_img'] = imgUrl;
      }
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> allFlights() async {
    final response = await supabase
        .from('flightsList')
        .select('*');
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;
      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in results) {
        var img = datas['airplane_img'];
        var name = datas['airport'];
        var pricePlace = datas['price'];
        var price = NumberFormat('#,###');
        var departure = datas['departure'];
        var arrival = datas['arrival'];
        var returnD = datas['return'];
        var returnArrival = datas['return_arrival'];
        var cleanTimeToString = returnD.split('+')[0];
        DateTime now = DateTime.now();
        DateTime dateFormatTo = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeToString.split(':')[0]),
            int.parse(cleanTimeToString.split(':')[1]),
            int.parse(cleanTimeToString.split(':')[2]));
        var formatTimeHe = DateFormat.jm().format(dateFormatTo);

        var cleanThis = returnArrival.split('+')[0];
        DateTime dateFormatreturn = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanThis.split(':')[0]),
            int.parse(cleanThis.split(':')[1]),
            int.parse(cleanThis.split(':')[2]));
        var formatTimeReturn = DateFormat.jm().format(dateFormatreturn);

        var cleanTimeToWhat = arrival.split('+')[0];
        DateTime dateFormathehe = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeToWhat.split(':')[0]),
            int.parse(cleanTimeToWhat.split(':')[1]),
            int.parse(cleanTimeToWhat.split(':')[2]));
        var formatTimeyan = DateFormat.jm().format(dateFormathehe);

        String cleanTimeString = departure.split('+')[0];
        DateTime dateFormat = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeString.split(':')[0]),
            int.parse(cleanTimeString.split(':')[1]),
            int.parse(cleanTimeString.split(':')[2]));
        var formatTime = DateFormat.jm().format(dateFormat);
        var format = price.format(pricePlace);
        var nameOfDeparture = datas['airplane'];

        var departureDate = datas['date_departure'];
        DateTime dateFormatDeparture = DateTime.parse(departureDate);
        var formatDateDeparture =
            DateFormat('MMM d').format(dateFormatDeparture);

        var date = datas['date'];
        DateTime dateFormatIto = DateTime.parse(date);
        var formatDateIto = DateFormat('MMM d').format(dateFormatIto);

        var dateArrival = datas['date_arrival'];
        DateTime dateFormatArrival = DateTime.parse(dateArrival);
        var formatDateArrival = DateFormat('MMM d').format(dateFormatArrival);

        var returnDate = datas['return_date'];
        DateTime dateReturnArrival = DateTime.parse(returnDate);
        var formatDateReturnArrival =
            DateFormat('MMM d').format(dateReturnArrival);

        datas['date_departure'] = formatDateDeparture;
        datas['date_arrival'] = formatDateArrival;
        datas['return_date'] = formatDateReturnArrival;
        datas['airplane'] = nameOfDeparture;
        datas['airport'] = name;
        datas['date'] = formatDateIto;
        datas['return_arrival'] = formatTimeReturn;
        datas['return'] = formatTimeHe;
        datas['arrival'] = formatTimeyan;
        datas['departure'] = formatTime;
        datas['price'] = format;
        var imgUrl = await getter(img);
        datas['airplane_img'] = imgUrl;
      }
      return data;
    }
  }

  Future<List<Map<String, dynamic>>> flightListFastest() async {
    final response = await supabase
        .from('flightsList')
        .select('*')
        .eq('ticket_type', 'fastest');
    if (response.isEmpty) {
      return [];
    } else {
      final data = response;
      final List<Map<String, dynamic>> results =
          List<Map<String, dynamic>>.from(data as List);
      for (var datas in results) {
        var img = datas['airplane_img'];
        var name = datas['airport'];
        var pricePlace = datas['price'];
        var price = NumberFormat('#,###');
        var departure = datas['departure'];
        var arrival = datas['arrival'];
        var returnD = datas['return'];
        var returnArrival = datas['return_arrival'];
        var cleanTimeToString = returnD.split('+')[0];
        DateTime now = DateTime.now();
        DateTime dateFormatTo = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeToString.split(':')[0]),
            int.parse(cleanTimeToString.split(':')[1]),
            int.parse(cleanTimeToString.split(':')[2]));
        var formatTimeHe = DateFormat.jm().format(dateFormatTo);

        var cleanThis = returnArrival.split('+')[0];
        DateTime dateFormatreturn = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanThis.split(':')[0]),
            int.parse(cleanThis.split(':')[1]),
            int.parse(cleanThis.split(':')[2]));
        var formatTimeReturn = DateFormat.jm().format(dateFormatreturn);

        var cleanTimeToWhat = arrival.split('+')[0];
        DateTime dateFormathehe = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeToWhat.split(':')[0]),
            int.parse(cleanTimeToWhat.split(':')[1]),
            int.parse(cleanTimeToWhat.split(':')[2]));
        var formatTimeyan = DateFormat.jm().format(dateFormathehe);

        String cleanTimeString = departure.split('+')[0];
        DateTime dateFormat = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(cleanTimeString.split(':')[0]),
            int.parse(cleanTimeString.split(':')[1]),
            int.parse(cleanTimeString.split(':')[2]));
        var formatTime = DateFormat.jm().format(dateFormat);
        var format = price.format(pricePlace);
        var nameOfDeparture = datas['airplane'];

        var departureDate = datas['date_departure'];
        DateTime dateFormatDeparture = DateTime.parse(departureDate);
        var formatDateDeparture =
            DateFormat('MMM d').format(dateFormatDeparture);

        var date = datas['date'];
        DateTime dateFormatIto = DateTime.parse(date);
        var formatDateIto = DateFormat('MMM d').format(dateFormatIto);

        var dateArrival = datas['date_arrival'];
        DateTime dateFormatArrival = DateTime.parse(dateArrival);
        var formatDateArrival = DateFormat('MMM d').format(dateFormatArrival);

        var returnDate = datas['return_date'];
        DateTime dateReturnArrival = DateTime.parse(returnDate);
        var formatDateReturnArrival =
            DateFormat('MMM d').format(dateReturnArrival);

        datas['date_departure'] = formatDateDeparture;
        datas['date_arrival'] = formatDateArrival;
        datas['return_date'] = formatDateReturnArrival;
        datas['airplane'] = nameOfDeparture;
        datas['airport'] = name;
        datas['date'] = formatDateIto;
        datas['return_arrival'] = formatTimeReturn;
        datas['return'] = formatTimeHe;
        datas['arrival'] = formatTimeyan;
        datas['departure'] = formatTime;
        datas['price'] = format;
        var imgUrl = await getter(img);
        datas['airplane_img'] = imgUrl;
      }
      return data;
    }
  }

  Future<String?> getter(String name) async {
    final response = supabase.storage.from('flights').getPublicUrl(name);
    if (response.isEmpty) {
      return null;
    } else {
      return response;
    }
  }
}
