import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Controllers/SearchController/searchController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Controllers/NetworkImages/imageFromSupabaseApi.dart';

class Explorenow extends StatefulWidget {
  const Explorenow({super.key});

  @override
  State<Explorenow> createState() => _ExplorenowState();
}

class _ExplorenowState extends State<Explorenow> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  late String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  late String manaoag = "assets/images/places/Manaoag.jpg";
  final _searchController = TextEditingController();
  String? email;
  late Usersss users = Usersss();
  late Data data = Data();
  List<Map<String, dynamic>> place = [];

  Future<void> places() async {
    final datas = await data.fetchImageandText();

    setState(() {
      place = datas;
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
        body: Stack(children: [
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
            const SizedBox(height: 30),
            Expanded(
                child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(children: <Widget>[
                          const DismissableFindMoreLocation(),
                          CategorySelect(
                            label: "Categories",
                            oppressed: () => print('Categories clicked'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: beachIcon,
                                    oppressed: () => Data().fetchImageandText(),
                                  ),
                                  const CategoryLabel(label: 'Hotels'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: foodIcon,
                                    oppressed: () =>
                                        print('Food Place clicked'),
                                  ),
                                  const CategoryLabel(label: 'Food Place'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: beachIcon,
                                    oppressed: () => print('Beaches clicked'),
                                  ),
                                  const CategoryLabel(label: 'Beaches'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: hotelIcon,
                                    oppressed: () => print('Festivals clicked'),
                                  ),
                                  const CategoryLabel(
                                      label: 'Festivals and \nEvents'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: place.map((place) {
                              final imageUrl = place['image_url'];
                              final text = place['place_name'] ?? 'Unknown';
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('test');
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 600,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(imageUrl),
                                        ),
                                        color: Colors.blue,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(top: 120),
                                        child: Text(
                                          '    $text',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            }).toList(),
                          ),
                        ]))))
          ]))
        ]));
  }
}

class CategoryLabel extends StatelessWidget {
  final String label;
  const CategoryLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: 50,
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DismissableFindMoreLocation extends StatefulWidget {
  const DismissableFindMoreLocation({super.key});

  @override
  _DismissableFindMoreLocationState createState() =>
      _DismissableFindMoreLocationState();
}

class _DismissableFindMoreLocationState
    extends State<DismissableFindMoreLocation> {
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}

class CategorySelect extends StatelessWidget {
  final String label;
  final VoidCallback oppressed;

  const CategorySelect({
    super.key,
    required this.label,
    required this.oppressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: oppressed,
              child: const Text(
                'View all',
                style: TextStyle(
                  color: Color.fromRGBO(33, 150, 243, 100),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
