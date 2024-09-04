import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itransit/Controllers/SearchController/searchController.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
          Positioned.fill(
              child: Column(
                children: <Widget>[
              Text(
                'TRAVEL GO',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(3.0, 3.0),
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            const Text(
              "Northwestern part of Luzon Island, Philippines",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    hintStyle: TextStyle(color: Colors.black54),
                    hintText: 'Search Destination',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
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
              ]
            )
          )
        ]
      )
    );
  }
}