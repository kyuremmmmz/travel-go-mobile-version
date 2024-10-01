import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itransit/Controllers/NetworkImages/festivalsList.dart';

import 'package:itransit/Controllers/NetworkImages/food_area.dart';
import 'package:itransit/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/PlaceButtonSquare.dart';
import 'package:itransit/Widgets/Drawer/drawerMenu.dart';
import 'package:itransit/Widgets/Screens/App/beachList.dart';
import 'package:itransit/Widgets/Screens/App/festivalsAbout.dart';
import 'package:itransit/Widgets/Screens/App/categories.dart';
import 'package:itransit/Widgets/Screens/App/foodAreaAbout.dart';
import 'package:itransit/Widgets/Screens/App/information.dart';
import 'package:itransit/Widgets/Screens/App/titleSearchMenu.dart';
import 'package:itransit/Widgets/Screens/Stateless/festivalsStateless.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  String? email;
  late Usersss users = Usersss();
  List<Map<String, dynamic>> place = [];
  final data = Data();
  late FoodAreaBackEnd images = FoodAreaBackEnd();
  List<Map<String, dynamic>> datass = [];
  late Festivalslist festivals = Festivalslist();
  List<Map<String, dynamic>> dataOfFestivals = [];
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
            place['place_name'] =
                place['place_name'].toString().substring(0, 18);
          }
          return place;
        },
      ).toList();
    });
  }

  Future<List<Map<String, dynamic>>?> fetchFoods(BuildContext context) async {
    final datas = await images.getFood();
    if (datas.isEmpty) {
      return [];
    } else {
      setState(() {
        datass = datas.map((foods) {
          if (foods['img'] != null && foods['img'].toString().length > 18) {
            foods['img'] = foods['img'].toString().substring(0, 18);
          }
          return foods;
        }).toList();
      });
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchFestivals(
      BuildContext context) async {
    final datas = await festivals.listOfFestivals();
    if (datas.isEmpty) {
      return [];
    } else {
      setState(() {
        dataOfFestivals = datas.map((foods) {
          if (foods['img'] != null && foods['img'].toString().length > 18) {
            foods['img'] = foods['img'].toString().substring(0, 18);
          }
          return foods;
        }).toList();
      });
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchImage();
    fetchFoods(context);
    fetchFestivals(context);
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
      drawer: const DrawerMenuWidget(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: <Widget>[
                const TitleSearchMenu(),
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
                                      oppressed: () => {
                                            AppRoutes.navigateToHotelScreen(
                                                context)
                                          }),
                                  const CategoryLabel(label: 'Hotels'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                      image: foodIcon,
                                      oppressed: () =>
                                          AppRoutes.navigateTofoodArea(
                                              context)),
                                  const CategoryLabel(label: 'Food Place'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: beachIcon,
                                    oppressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Beaches())),
                                  ),
                                  const CategoryLabel(label: 'Beaches'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: hotelIcon,
                                    oppressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Festivalsstateless())),
                                  ),
                                  const CategoryLabel(
                                      label: 'Festivals and \nEvents'),
                                ],
                              ),
                            ],
                          ),

                          const Categories(),

                          CategorySelect(
                            label: "Popular Places",
                            oppressed: () =>
                                AppRoutes.navigateToExploreNowScreen(context),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: place.map((place) {
                                final id = place['id'];
                                return PlaceButtonSquare(
                                    place: place['place_name'],
                                    image: Image.network(place['image']).image,
                                    oppressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InformationScreen(text: id)));
                                    });
                              }).toList()),
                          CategorySelect(
                            label: "Food Places",
                            oppressed: () => print('Food Places clicked'),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: datass.map((value) {
                                final id = value['id'];
                                return PlaceButtonSquare(
                                    place: value['img'],
                                    image: Image.network(value['imgUrl']).image,
                                    oppressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FoodAreaAboutScreen(id: id)));
                                    });
                              }).toList()),
                          CategorySelect(
                            label: "Festival and Events",
                            oppressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FestivalsStateless())),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: dataOfFestivals.map((value) {
                                final id = value['id'];
                                return PlaceButtonSquare(
                                    place: value['img'],
                                    image: Image.network(value['imgUrl']).image,
                                    oppressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FestivalsAboutScreen(id: id)));
                                    });
                              }).toList()),
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
