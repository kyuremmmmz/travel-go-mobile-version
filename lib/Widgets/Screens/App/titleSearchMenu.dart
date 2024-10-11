import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/SearchController/searchController.dart';

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
        const Text(
          'TRAVEL GO',
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Northwestern part of Luzon Island, Philippines",
          style: TextStyle(fontSize: 16), // Adjust text style as needed
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
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
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                hintStyle: const TextStyle(color: Colors.black54),
                hintText: 'Search Destination',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                filled: true,
                fillColor: Colors.white,
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
