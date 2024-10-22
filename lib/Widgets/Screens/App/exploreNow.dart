import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Screens/App/searchMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:TravelGo/Widgets/Screens/App/information.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

// THE POPULAR PLACES YUNG SA VIEW ALL  DITO YUN

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

  Future<void> redirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

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

  // AREA OF POPULAR PLACES VIEW ALL SEARCH DESTINATION LOGO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40.h,
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
            future: redirecting(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: Text(
                    'No internet connection',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                );
              } else {
                return Stack(children: [
                  Positioned.fill(
                      child: Column(children: <Widget>[
                    const TitleMenu(),
                    const SearchMenu(),
                    const SizedBox(height: 30),
                    Expanded(
                        child: Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(children: <Widget>[
                                  CategorySelect(
                                    label: "Categories",
                                    oppressed: () =>
                                        print('Categories clicked'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          BlueIconButtonDefault(
                                              image: hotelIcon,
                                              oppressed: () => {
                                                    AppRoutes
                                                        .navigateToHotelScreen(
                                                            context)
                                                  }),
                                          CategoryLabel(
                                              label: 'Hotels',
                                              fontSize: 12.0
                                                  .sp), // Specify font size here
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          BlueIconButtonDefault(
                                              image: foodIcon,
                                              oppressed: () =>
                                                  AppRoutes.navigateTofoodArea(
                                                      context)),
                                          CategoryLabel(
                                              label: 'Food Place',
                                              fontSize: 11.0.sp),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          BlueIconButtonDefault(
                                            image: beachIcon,
                                            oppressed: () => {
                                              AppRoutes.navigateToBeachesScreen(
                                                  context)
                                            },
                                          ),
                                          CategoryLabel(
                                              label: 'Beaches',
                                              fontSize: 11.0.sp),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          BlueIconButtonDefault(
                                            image: hotelIcon,
                                            oppressed: () => {
                                              AppRoutes
                                                  .navigateToFestivalsScreen(
                                                      context)
                                            },
                                          ),
                                          CategoryLabel(
                                              label: 'Festivals and \nEvents',
                                              fontSize: 11.0.sp),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // MEDYO MAGULO DITO NAK, CLICKING THE POPLUAR PLACES DITO FRONT-END
                                  SizedBox(height: 10.h),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 190.w, bottom: 5.h),
                                    child: Text(
                                      'Popular Places',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(255, 49, 49, 49),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    children: place.map((place) {
                                      final imageUrl = place['image'];
                                      final text =
                                          place['place_name'] ?? 'Unknown';
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final placeData = await Data()
                                                  .fetchSpecificDataInSingle(
                                                      place['id']);
                                              if (placeData != null) {
                                                Navigator.push(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        InformationScreen(
                                                      text: place['id'],
                                                      name: place['place_name'],
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Stack(
                                              // area of the popular places images VIEW ALL POPULAR PLACES
                                              children: [
                                                Container(
                                                  height: 150.h,
                                                  width: 600.w,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          imageUrl),
                                                    ),
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15
                                                          .w), // radius area of populara places images
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.w),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.12),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                30.w),
                                                        bottomRight:
                                                            Radius.circular(
                                                                30.w),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      // color area of text in each hotels.
                                                      text,
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
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
                                          SizedBox(height: 20.h),
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

class CategoryLabel extends StatelessWidget {
  final String label;
  final double fontSize; // Add fontSize parameter of the categories

  const CategoryLabel({
    super.key,
    required this.label,
    this.fontSize = 14.0, // Default font size
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w, bottom: 5.h),
      child: SizedBox(
        height: 35.h,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500, // Use the fontSize parameter here
          ),
        ),
      ),
    );
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
        SizedBox(height: 30.h),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 9.0), // Add padding to left and right
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  // Text area for the categories, Popular places, food places, and Festival and events.
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp, // Add font size
                ),
              ),
              GestureDetector(
                onTap: oppressed,
                child: const Text(
                  'View all',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.bold,
                    fontSize: 13, // Add font size
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
