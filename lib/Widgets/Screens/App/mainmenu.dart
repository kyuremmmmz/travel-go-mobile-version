import 'package:TravelGo/Controllers/NetworkImages/beach_images.dart';
import 'package:TravelGo/Controllers/NetworkImages/hotel_images.dart';
import 'package:TravelGo/Controllers/NetworkImages/vouchers.dart';
import 'package:TravelGo/Widgets/Screens/App/InfoScreens/BeachInfo.dart';
import 'package:TravelGo/Widgets/Screens/App/InfoScreens/HotelsInfo.dart';
import 'package:TravelGo/Widgets/Screens/App/searchMenu.dart';
import 'package:flutter/material.dart'; // The flutter material package for UI e stateless wdiget for festivals
import 'package:supabase_flutter/supabase_flutter.dart'; // Importing the Supabase Flutter package for database functionality.
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness // The flutter material package for UI
import 'package:TravelGo/Controllers/NetworkImages/festivals_images.dart';
import 'package:TravelGo/Controllers/NetworkImages/food_area.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/PlaceButtonSquare.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/InfoScreens/FestivalsInfo.dart';
import 'package:TravelGo/Widgets/Screens/App/categories.dart';
import 'package:TravelGo/Widgets/Screens/App/InfoScreens/FoodAreaInfo.dart';
import 'package:TravelGo/Widgets/Screens/App/InfoScreens/PlacesInfo.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:TravelGo/Widgets/Screens/Stateless/festivalsStateless.dart';

void main() {
  runApp(const MainMenu()); // running the main application
}

class MainMenu extends StatelessWidget {
  // creating a stateless widget for the main menu
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
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
  String? email; // the variable to store the user's email
  late Usersss users = Usersss(); // Instance of unserss controller
  List<Map<String, dynamic>> place = []; // list to hold place data
  final data = Data(); // instance of the data controller
  final datahotel = HotelImages();
  List<Map<String, dynamic>> placehotel = [];
  late FoodAreaBackEnd images = FoodAreaBackEnd();
  List<Map<String, dynamic>> datass = [];
  final databeach = BeachImages();
  List<Map<String, dynamic>> placebeach = [];
  late FestivalsImages festivals = FestivalsImages();
  List<Map<String, dynamic>> dataOfFestivals = [];
  bool isLoading = false;
  final voucher = Vouchers();
  Map<String, dynamic>? voucherHolder;
  // Method to fetch user email
  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users
          .fetchUser(); // this fetching user email from the controller
      if (useremail.isNotEmpty) {
        // area of checking if the email is found
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

// Method to fetch images and place names
  Future<void> fetchImage() async {
    setState(() {
      isLoading = false;
    });
    try {
      final datas = await data.fetchImageandText();
      if (datas.isNotEmpty) {
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
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> voucherState() async {
    final data = await voucher.insertRandomlyThevouchers();
    setState(() {
      voucherHolder = data;
      SnackBar(content: Text('You received $voucherHolder'));
    });
  }

  Future<List<Map<String, dynamic>>?> fetchHotels(BuildContext context) async {
    final datas = await datahotel.fetchHotels();
    if (datas.isEmpty) {
      return [];
    } else {
      setState(() {
        placehotel = datas.map((hotel) {
          if (hotel['hotel_name'] != null &&
              hotel['hotel_name'].toString().length > 18) {
            hotel['hotel_name'] =
                hotel['hotel_name'].toString().substring(0, 18);
          }
          return hotel;
        }).toList();
      });
      return null;
    }
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

  Future<List<Map<String, dynamic>>?> fetchBeach(BuildContext context) async {
    final datas = await databeach.fetchBeaches();
    if (datas.isNotEmpty) {
      setState(() {
        placebeach = datas.map((beach) {
          if (beach['beach_name'] != null &&
              beach['beach_name'].toString().length > 18) {
            beach['beach_name'] =
                beach['beach_name'].toString().substring(0, 18);
          }
          return beach;
        }).toList();
      });
    }
    return null;
  }

// Method to fetch food area
  Future<List<Map<String, dynamic>>?> fetchFestivals(
      BuildContext context) async {
    final datas = await festivals.fetchFestivals(); // Fetching food area
    if (datas.isEmpty) {
      return [];
    } else {
      setState(() {
        dataOfFestivals = datas.map((foods) {
          if (foods['img'] != null && foods['img'].toString().length > 18) {
            // Limiting
            foods['img'] = foods['img'].toString().substring(0, 18); // Trimmimg
          }
          return foods;
        }).toList();
      });
      return null;
    }
  }

  @override
  void initState() {
    super.initState(); //calling the parent class's initState method
    emailFetching(); // Fetching user email and initialization
    fetchImage(); // fetching the images on initialization
    fetchHotels(context);
    fetchFoods(context); // fetching food areas on initialization
    fetchBeach(context);
    fetchFestivals(context); // Fetching festivals on initialization
    voucherState(); // Fetching random vouchers on initialization
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: <Widget>[
                const TitleMenu(),
                const SearchMenu(),
                SizedBox(height: 10.h),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const DismissableFindMoreLocation(),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Categories()),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10.h, left: 20.w),
                              child: CategorySelect(
                                label: "Popular Places",
                                oppressed: () =>
                                    AppRoutes.navigateToExploreNowScreen(
                                        context),
                              )),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.sp)),
                                    color: Colors.grey[100],
                                  ),
                                  child: Row(
                                      children: isLoading
                                          ? [
                                              SizedBox(
                                                width: 100.w,
                                                height: 100.h,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : place.map((place) {
                                              final id = place['id'];
                                              return PlaceButtonSquare(
                                                place: place['place_name'],
                                                image: Image.network(
                                                        place['image'])
                                                    .image,
                                                oppressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PlacesInfo(text: id),
                                                    ),
                                                  );
                                                },
                                              );
                                            }).toList()))),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10.h, left: 20.w),
                              child: CategorySelect(
                                label: "Popular Hotels",
                                oppressed: () =>
                                    AppRoutes.navigateToHotelScreen(context),
                              )),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.sp)),
                                    color: Colors.grey[100],
                                  ),
                                  child: Row(
                                      children: isLoading
                                          ? [
                                              SizedBox(
                                                width: 100.w,
                                                height: 100.h,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : placehotel.map((hotel) {
                                              final id = hotel['id'];
                                              return PlaceButtonSquare(
                                                  place: hotel['hotel_name'],
                                                  image: Image.network(
                                                          hotel['image'])
                                                      .image,
                                                  oppressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    HotelsInfo(
                                                                      id: id,
                                                                      text: id,
                                                                    )));
                                                  });
                                            }).toList()))),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10.h, left: 20.w),
                              child: CategorySelect(
                                label: "Food Places",
                                oppressed: () =>
                                    AppRoutes.navigateTofoodArea(context),
                              )),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.sp)),
                                    color: Colors.grey[100],
                                  ),
                                  child: Row(
                                      children: isLoading
                                          ? [
                                              SizedBox(
                                                width: 100.w,
                                                height: 100.h,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : datass.map((value) {
                                              final id = value['id'];
                                              return PlaceButtonSquare(
                                                  place: value['img'],
                                                  image: Image.network(
                                                          value['imgUrl'])
                                                      .image,
                                                  oppressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                FoodAreaInfo(
                                                                    id: id)));
                                                  });
                                            }).toList()))),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10.h, left: 20.w),
                              child: CategorySelect(
                                label: "Beach Destinations",
                                oppressed: () =>
                                    AppRoutes.navigateToBeachesScreen(context),
                              )),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.sp)),
                                    color: Colors.grey[100],
                                  ),
                                  child: Row(
                                      children: isLoading
                                          ? [
                                              SizedBox(
                                                width: 100.w,
                                                height: 100.h,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : placebeach.map((beach) {
                                              final id = beach['id'];
                                              return PlaceButtonSquare(
                                                  place: beach['beach_name'],
                                                  image: Image.network(
                                                          beach['image'])
                                                      .image,
                                                  oppressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BeachInfo(
                                                                    id: id)));
                                                  });
                                            }).toList()))),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 10.h, left: 20.w),
                              child: CategorySelect(
                                label: "Festival and Events",
                                oppressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FestivalsStateless())),
                              )),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.sp)),
                                    color: Colors.grey[100],
                                  ),
                                  child: Row(
                                      children: isLoading
                                          ? [
                                              SizedBox(
                                                width: 100.w,
                                                height: 100.h,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : dataOfFestivals.map((value) {
                                              final id = value['id'];
                                              return PlaceButtonSquare(
                                                  place: value['img'],
                                                  image: Image.network(
                                                          value['imgUrl'])
                                                      .image,
                                                  oppressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                FestivalsInfo(
                                                                    id: id)));
                                                  });
                                            }).toList()))),
                          SizedBox(height: 30.h),
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

// THIS END OF THE BACKEND (DART)

class DismissableFindMoreLocation extends StatefulWidget {
  const DismissableFindMoreLocation({super.key});

  @override
  _DismissableFindMoreLocationState createState() =>
      _DismissableFindMoreLocationState();
}

class _DismissableFindMoreLocationState
    extends State<DismissableFindMoreLocation> {
  bool _isVisible = true;
  final String xButtonIcon = "assets/images/icon/ButtonX.png"; // exit button
  final String adventureIcon =
      "assets/images/icon/adventure.png"; // the icon of blue-pop

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Center(
            child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2196F3),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 5.w),
                              child: Text(
                                'Find more location \naround you',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 15.w),
                              child: Text(
                                'Find your next adventure around Pangasinan \nand create unforgettable memories!',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(top: 5.h),
                            width: 110.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    iconSize: 20.sp,
                                    icon: SizedBox(
                                      height: 20.sp,
                                      width: 20.sp,
                                      child: Image.asset(xButtonIcon),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = false;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 10.w),
                                  height: 100.sp,
                                  width: 100.sp,
                                  child: Image.asset(adventureIcon),
                                ),
                              ],
                            )),
                      ]),
                      Row(children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 30.w, bottom: 20.h),
                            child: GestureDetector(
                              onTap: () =>
                                  AppRoutes.navigateToExploreNowScreen(context),
                              child: Text('Explore now!',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.transparent,
                                    decoration: TextDecoration.underline,
                                    shadows: const [
                                      Shadow(
                                          color: Colors.white,
                                          offset: Offset(0, -5))
                                    ],
                                    decorationColor:
                                        Colors.white, // Set the underline color
                                    fontWeight: FontWeight.w900,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationThickness: 3,
                                  )),
                            ))
                      ])
                    ],
                  ),
                )),
          )
        : const SizedBox(height: 0);
  }
}
