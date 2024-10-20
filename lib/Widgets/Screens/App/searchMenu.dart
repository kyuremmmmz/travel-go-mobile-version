import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/SearchController/searchController.dart'; // responsiveness

class SearchMenu extends StatefulWidget {
  const SearchMenu({super.key});

  @override
  State<SearchMenu> createState() => _SearchMenuState();
}

class _SearchMenuState extends State<SearchMenu> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> place = [];
  final data = Data();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Container(
    // color: Colors.white, // Add your desired background color here just incase po 
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 23.w), // Search bar in Home Main Front-end Dito
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      await data.fetchinSearch(
                          _searchController.text.trim(), context);
                    },
                    icon: const Icon(
                      Icons.search,
                    )),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.w, horizontal: 10.w),
                hintStyle: const TextStyle(color: Colors.black54),
                hintText: 'Search Destination',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.h)),
                  borderSide: BorderSide.none, // Removed the border
                ),
                filled: true,
                fillColor: const Color(0XffDEDEDE), // Background color of the text field
              ),
            ),
            suggestionsCallback: (pattern) async {
              return await Searchcontroller().fetchSuggestions(pattern);
            },
            itemBuilder: (context, dynamic suggestion) {
              return ListTile(
                title: Text(suggestion['title'] ?? 'No title'),
                subtitle: Text(suggestion['address'] ?? 'No address'),
              );
            },
            onSuggestionSelected: (dynamic suggestion) {
              _searchController.text = suggestion['title'] ?? 'No title';
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    ),
  );
}
}
