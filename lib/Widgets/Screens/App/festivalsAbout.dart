// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Widgets/Screens/App/searchMenu.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/NetworkImages/festivals_images.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'ResponsiveScreen/ResponsiveScreen.dart';

// ignore: must_be_immutable
class FestivalsAbout extends StatelessWidget {
  String? name;
  int id;
  FestivalsAbout({
    super.key,
    this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel',
      home: FestivalsAboutScreen(
        id: id,
      ),
    );
  }
}

// ignore: must_be_immutable
class FestivalsAboutScreen extends StatefulWidget {
  String? name;
  int id;
  FestivalsAboutScreen({
    super.key,
    this.name,
    required this.id,
  });

  @override
  State<FestivalsAboutScreen> createState() => _FestivalsAboutScreenState();
}

class _FestivalsAboutScreenState extends State<FestivalsAboutScreen> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";

  String? email;
  String? description;
  String? menu;
  String? placeName;
  String? imageUrl;
  var id;
  String? located;
  String? foodName;
  String? price;
  var amenities = <String, dynamic>{};
  var imageUrlForAmenities = <String, dynamic>{};
  final data = FestivalsImages();

  final _searchController = TextEditingController();
  late Usersss users = Usersss();
  List<Map<String, dynamic>> place = [];

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
    final datas = await data.fetchFestivals();
    setState(() {
      place = datas.map(
        (place) {
          if (place['img'] != null && place['img'].toString().length > 50) {
            place['img'] = place['img'].toString().substring(0, 50);
          }
          return place;
        },
      ).toList();
    });
  }

  Future<void> fetchSpecificData(int name) async {
    try {
      final dataList = await data.getSpecificData(name);

      if (dataList == null) {
        setState(() {
          description = "No description available";
        });
      } else {
        setState(() {
          description = dataList['Description'];
          foodName = dataList['img'];
          imageUrl = dataList['imgUrl'].toString();
          located = dataList['Located'];
          id = dataList['id'];
          menu = dataList['TipsForVisitors'];
          price = dataList['price'];
          for (var i = 1; i <= 20; i++) {
            final key = 'Dine$i';
            final keyUrl = 'DineUrl$i';
            final value = dataList[key];
            final imageUrlValue = dataList[keyUrl];
            if (value != null) {
              amenities[key] = value;
              imageUrlForAmenities[key] = imageUrlValue;
              print(imageUrlForAmenities);
            }
          }
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
  void initState() {
    super.initState();
    emailFetching();
    fetchImage();
    fetchSpecificData(widget.id);
  }

  Future<void> _isRedirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    const Positioned(
                      child: Column(
                        children: <Widget>[
                          TitleMenu(),
                          SearchMenu(),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: Responsive().infoSizePictureTop(context),
                          child: Container(
                            height: Responsive().infoSizePictureHeight(context),
                            width: Responsive().infoSizePictureWidth(context),
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
                          height: Responsive().scrollableContainerInfoHeight(context),
                          child: Container(
                            padding: const EdgeInsets.only(left: 0, top: 30),
                            width: 500,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Text(
                                          foodName ?? 'No data available',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:  Responsive().titleFontSize(),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                AppRoutes.navigateToTesting(
                                                    context,
                                                    name: '$located',
                                                    id: id);
                                              },
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    located ?? 'I cant locate it',
                                                    style: TextStyle(
                                                      fontSize: Responsive().aboutFontSize(),
                                                      decoration: TextDecoration.underline,
                                                      color: Colors.blue),
                                                  ),
                                                  FaIcon(
                                                    FontAwesomeIcons.map,
                                                    size: Responsive().clickToOpenFontSize(),
                                                    color: Colors.red,
                                                  ),
                                              ],
                                            ) 
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: Responsive().aboutPlacement()),
                                        child: Text(
                                          'About',
                                          style: TextStyle(
                                              fontSize: Responsive().headerFontSize(),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 30, right: 30),
                                        child: Text(
                                          description ?? 'No Description',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: Responsive().aboutFontSize()),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: Responsive().highlightsPlacement()),
                                        child: Text(
                                          'Festival Highlights',
                                          style: TextStyle(
                                              fontSize: Responsive().headerFontSize(),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                          children: imageUrlForAmenities.entries
                                              .map((entry) {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: Responsive().amenitiesBoxHeight(),
                                                    width: Responsive().amenitiesBoxWidth(),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            entry.value ?? ''),
                                                      ),
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
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
                                                              Radius.circular(
                                                                  30),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  30),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        amenities[entry.key] ??
                                                            '',
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
                                            )
                                          ],
                                        );
                                      }).toList()),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: Responsive().festivalTipsPlacement(),
                                        ),
                                        child: Text(
                                          'Tips for the Visitors',
                                          style: TextStyle(
                                              fontSize: Responsive().headerFontSize(),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 30, right: 30),
                                        child: Text(
                                          menu ?? 'No Description',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: Responsive().aboutFontSize()),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
            }));
  }
}
