import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Controllers/SearchController/searchController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/PlaceButtonSquare.dart';
import 'package:itransit/Widgets/Screens/App/information.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Controllers/NetworkImages/imageFromSupabaseApi.dart';

void main() {
  runApp(const MainMenu());
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel',
      home: MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  final _searchController = TextEditingController();
  String? email;
  late Usersss users = Usersss();
  List<Map<String, dynamic>> place = [];
  final data = Data();

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

  Future<void> fetchImage() async {
    final datas = await data.fetchImageandText();
    setState(() {
      place = datas.map(
        (place) {
          if (place['place_name'] != null &&
              place['place_name'].toString().length > 18) {
            place['place_name'] = place['place_name'].toString().substring(0, 18);
          }
          return place;
        },
      ).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchImage();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    backgroundImage: AssetImage('assets/images/icon/beach.png'),
                    radius: 40,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // ignore: unnecessary_null_comparison
                    email != null ? '$email' : 'Hacked himala e',
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
      body: Stack(
        children: [
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
                  style: TextStyle(fontSize: 16), // Adjust text style as needed
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(height: 30),
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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
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
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
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
                                    oppressed: () => print('test')
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
                          CategorySelect(
                            label: "Popular Places",
                            oppressed: () =>
                                AppRoutes.navigateToExploreNowScreen(context),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: place.map((place) {
                                final image = place['image'];
                                final text = place['place_name'];
                                final id = place['id'];
                                return PlaceButtonSquare(
                                    place: place['place_name'],
                                    image:
                                        Image.network(place['image']).image,
                                    oppressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InformationScreen(
                                                      text: id
                                                        )
                                                      )
                                                    );
                                                  }
                                                );
                                              }
                                            ).toList()),
                          CategorySelect(
                            label: "Food Places",
                            oppressed: () => print('Food Places clicked'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Food Place clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Food Place clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Food Place clicked'),
                              ),
                            ],
                          ),
                          CategorySelect(
                            label: "Festival and Events",
                            oppressed: () =>
                                print('Festival and Events clicked'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Event clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Event clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Event clicked'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
  bool _isVisible = true;
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Center(
            child: Container(
              height: 180,
              width: 380,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '  Find more location\n  around you',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '    Find your next adventure around Pangasinan \n    and create unforgettable memories!',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () =>
                                    AppRoutes.navigateToExploreNowScreen(
                                        context),
                                child: Stack(
                                  children: [
                                    const Text(
                                      '    Explore now',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        decoration: TextDecoration
                                            .none, // Disable the default underline
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 10,
                                      right: 0,
                                      child: Container(
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: 100,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                iconSize: 20,
                                icon: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(xButtonIcon),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset(adventureIcon),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container();
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
