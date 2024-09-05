// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:itransit/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Controllers/SearchController/searchController.dart';
import 'package:itransit/Routes/Routes.dart';

class InformationScreen extends StatefulWidget {
  final String text;
  final String description;
  final String imageUrl;
  const InformationScreen({
    super.key,
    required this.text,
    required this.description,
    required this.imageUrl,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _searchController = TextEditingController();
  String? email;
  String? description;
  String? text;
  String? hasCar;
  String? imageUrl;
  final data = Data();
  late Usersss users = Usersss();

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchSpecificData(widget.text);
  }

  Future<void> _isRedirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

  Future<void> fetchSpecificData(String name) async {
    try {
      final dataList = await data.fetchSpecificDataInSingle(name);

      if (dataList == null) {
        setState(() {
          description = "No description available";
        });
      } else {
        setState(() {
          description = dataList['description'];
          text = dataList['place_name'];
          imageUrl = dataList['image'].toString();
          hasCar = dataList['car_availability'];
        });
      }
    } catch (e) {
      setState(() {
        description = "Error fetching data";
      });
      print('Error in fetchSpecificData: $e');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users.fetchUser();
      if (useremail.isNotEmpty) {
        setState(() {
          email = useremail[0]['full_name'].toString();
        });
      } else {
        setState(() {
          email = "Anonymous User";
        });
      }
    } catch (e) {
      setState(() {
        email = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          leading: Builder(
            builder: (BuildContext context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/icon/beach.png'),
                      radius: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      email ?? 'Hacked himala e',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  AppRoutes.navigateToMainMenu(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  Usersss().signout(context);
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: _isRedirecting(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                final error = snapshot.error;
                return Text('Error: $error');
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text(
                    'No connection to the server',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Positioned(
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  hintStyle: TextStyle(color: Colors.black54),
                                  hintText: 'Search Destination',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    borderSide:
                                        BorderSide(color: Colors.black54),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              suggestionsCallback: (pattern) async {
                                return await Searchcontroller()
                                    .fetchSuggestions(pattern);
                              },
                              itemBuilder: (context, dynamic suggestion) {
                                return ListTile(
                                  title:
                                      Text(suggestion['title'] ?? 'No title'),
                                  subtitle: Text(
                                      suggestion['address'] ?? 'No address'),
                                );
                              },
                              onSuggestionSelected: (dynamic suggestion) {
                                _searchController.text =
                                    suggestion['title'] ?? 'No title';
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 160,
                          child: Container(
                            height: 300,
                            width: 500,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageUrl != null &&
                                            imageUrl!.isNotEmpty
                                          ? NetworkImage(imageUrl!)
                                          : const AssetImage(
                                            'assets/images/places/PangasinanProvincialCapitol.jpg'))),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            height: 390,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  left: 0,
                                                  top: 30
                                                ),
                                                width: 500,
                                                decoration: 
                                                const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(50),
                                                    topRight: Radius.circular(50)
                                                  )
                                                ),
                                                // ignore: avoid_unnecessary_containers
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      // ignore: avoid_unnecessary_containers
                                                      Container(
                                                        child: Text(
                                                            text ?? 'No data available',
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 25,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.only(
                                                          right: 300
                                                        ),
                                                        child: const Text(
                                                          'About',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }
                              }
                            )
                          );
  }
}
