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
                horizontal: 20.w), // Search bar in Home Main Front-end Dito
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchController,
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        await data.fetchinSearch(
                            _searchController.text.trim(), context);
                      },
                      icon: Icon(
                        Icons.search,
                        size: 25.sp,
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                  hintStyle: TextStyle(fontSize: 16.sp, color: Colors.black54),
                  hintText: 'Search Destination',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.h)),
                    borderSide: BorderSide.none, // Removed the border
                  ),
                  filled: true,
                  fillColor: const Color(
                      0XffDEDEDE), // Background color of the text field
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await Searchcontroller().fetchSuggestions(pattern);
              },
              itemBuilder: (context, dynamic suggestion) {
                return SingleChildScrollView(
                    child: ListTile(
                        title: Text(suggestion['place_name'] ?? 'No title',
                            style: TextStyle(fontSize: 16.sp)),
                        subtitle: Text(suggestion['locatedIn'] ?? 'No address',
                            style: TextStyle(fontSize: 12.sp)),
                        leading: Image.network(
                          suggestion['image'] ?? 'No image',
                          fit: BoxFit.cover,
                          width: 70.sp,
                          height: 70.sp,
                        )));
              },
              onSuggestionSelected: (dynamic suggestion) {
                _searchController.text = suggestion['place_name'] ?? 'No title';
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
