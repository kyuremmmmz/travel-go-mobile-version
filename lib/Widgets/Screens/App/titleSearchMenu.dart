import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itransit/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:itransit/Controllers/SearchController/searchController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

class TitleSearchMenu extends StatefulWidget {
  const TitleSearchMenu({super.key});

  @override
  State<TitleSearchMenu> createState() => _TitleSearchMenuState();
}

class _TitleSearchMenuState extends State<TitleSearchMenu> {
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
    return Column(
      children: [
        Text(
          'TRAVEL GO', // The home Travel Go Icon
          style: TextStyle(
            fontSize: 30.sp,
            color: Color(0xFF44CAF9),
            fontWeight: FontWeight.bold,
            shadows: [
            Shadow(
              offset: Offset(2.0.h, -2.0.h), // Position of the shadow (x, y)
              blurRadius: 20, // Blur effect of the shadow
              color: Color.fromARGB(128, 117, 116, 116), // Shadow color with opacity
            ),
          ],
          ),
        ),
        Text(
          "Northwestern part of Luzon Island, Philippines", // The home address of Pangasinan
          style: TextStyle(fontSize: 12.sp), // Adjust text style as needed
        ),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w), // Search bar in Home Main Fron-end Dito
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
                fillColor: Color(0XffDEDEDE),
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
    );
  }
}
