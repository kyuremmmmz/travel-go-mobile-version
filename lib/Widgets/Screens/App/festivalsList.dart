import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itransit/Controllers/NetworkImages/festivals_images.dart';
import 'package:itransit/Controllers/NetworkImages/food_area.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Controllers/SearchController/searchController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Screens/App/categories.dart';
import 'package:itransit/Widgets/Screens/App/foodAreaAbout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Festival extends StatefulWidget {
  const Festival({super.key});

  @override
  State<Festival> createState() => _FestivalState();
}

class _FestivalState extends State<Festival> {
  late String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  late String manaoag = "assets/images/places/Manaoag.jpg";
  final _searchController = TextEditingController();
  String? email;
  late Usersss users = Usersss();
  late FestivalsImages images = FestivalsImages();
  List<Map<String, dynamic>> data = [];

  Future<void> redirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

  Future<void> places() async {
    final datas = await images.fetchFestivals();
    setState(() {
      data = datas;
    });
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    places();
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
        email = "error: $e";
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
                      email ?? 'LoFestival',
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
            future: redirecting(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text(
                    'No internet connection',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else {
                return Stack(children: [
                  Positioned.fill(
                      child: Column(children: <Widget>[
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
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
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
                            title: Text(suggestion['title'] ?? 'No title'),
                            subtitle:
                                Text(suggestion['address'] ?? 'No address'),
                          );
                        },
                        onSuggestionSelected: (dynamic suggestion) {
                          _searchController.text =
                              suggestion['title'] ?? 'No title';
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                        child: Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(children: <Widget>[
                                  const Categories(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    children: data.map((place) {
                                      final imageUrl = place['imgUrl'];
                                      final text = place['img'] ?? 'Unknown';
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final placeData =
                                                  await FoodAreaBackEnd()
                                                      .getSpecificData(
                                                          place['id']);
                                              if (placeData != null) {
                                                Navigator.push(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FoodAreaAboutScreen(
                                                            id: place['id'],
                                                          )),
                                                );
                                              }
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 150,
                                                  width: 600,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          imageUrl),
                                                    ),
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(30),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.12),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(30),
                                                        bottomRight:
                                                            Radius.circular(30),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      text,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ]))))
                  ]))
                ]);
              }
            }));
  }
}
