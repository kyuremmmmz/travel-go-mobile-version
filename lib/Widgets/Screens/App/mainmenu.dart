import 'package:TravelGo/Controllers/NetworkImages/beach_images.dart';
import 'package:TravelGo/Controllers/NetworkImages/vouchers.dart';
import 'package:TravelGo/Widgets/Screens/App/InfoScreens/BeachInfo.dart';
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
  String? email; // the variable to store the user's email
  late Usersss users = Usersss(); // Instance of unserss controller
  List<Map<String, dynamic>> place = []; // list to hold place data
  final data = Data(); // instance of the data controller
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
                              padding: EdgeInsets.only(left: 20.w),
                              child: CategorySelect(
                                label: "Popular Places",
                                oppressed: () =>
                                    AppRoutes.navigateToExploreNowScreen(
                                        context),
                              )),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: isLoading
                                    ? [
                                        SizedBox(
                                          width: 100.w,
                                          height: 100.h,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ]
                                    : place.map((place) {
                                        final id = place['id'];
                                        return PlaceButtonSquare(
                                          place: place['place_name'],
                                          image: Image.network(place['image'])
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
                                      }).toList(),
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20.w),
                              child: CategorySelect(
                                label: "Food Places",
                                oppressed: () =>
                                    AppRoutes.navigateTofoodArea(context),
                              )),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: isLoading
                                      ? [
                                          SizedBox(
                                            width: 100.w,
                                            height: 100.h,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ]
                                      : datass.map((value) {
                                          final id = value['id'];
                                          return PlaceButtonSquare(
                                              place: value['img'],
                                              image:
                                                  Image.network(value['imgUrl'])
                                                      .image,
                                              oppressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FoodAreaInfo(
                                                                id: id)));
                                              });
                                        }).toList())),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20.w),
                              child: CategorySelect(
                                label: "Beach Destinations",
                                oppressed: () =>
                                    AppRoutes.navigateToBeachesScreen(context),
                              )),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: isLoading
                                      ? [
                                          SizedBox(
                                            width: 100.w,
                                            height: 100.h,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ]
                                      : placebeach.map((beach) {
                                          final id = beach['id'];
                                          return PlaceButtonSquare(
                                              place: beach['beach_name'],
                                              image:
                                                  Image.network(beach['image'])
                                                      .image,
                                              oppressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BeachInfo(id: id)));
                                              });
                                        }).toList())),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20.w),
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
                              child: Row(
                                  children: isLoading
                                      ? [
                                          SizedBox(
                                            width: 100.w,
                                            height: 100.h,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ]
                                      : dataOfFestivals.map((value) {
                                          final id = value['id'];
                                          return PlaceButtonSquare(
                                              place: value['img'],
                                              image:
                                                  Image.network(value['imgUrl'])
                                                      .image,
                                              oppressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FestivalsInfo(
                                                                id: id)));
                                              });
                                        }).toList())),
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
            child: Container(
              height: 200.h,
              width: 390.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: const BoxDecoration(
                color: Color(0xFF2196F3),
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 200.w,
                                margin: EdgeInsets.only(
                                    left: 14.0.h,
                                    right: 16.0.h,
                                    top: 35.0.h), // Add left and right margin
                                child: Text(
                                  '  Find more location\n  around you',
                                  style: TextStyle(
                                    fontSize: 21
                                        .sp, // Assuming .sp is handled correctly in your project
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 500.w,
                                margin: EdgeInsets.only(
                                    left: 14.0.h,
                                    right: 16.0.h,
                                    top: 5.0.h), // Add left and right margin
                                child: Text(
                                  '    Find your next adventure around Pangasinan \n    and create unforgettable memories!',
                                  style: TextStyle(
                                    fontSize: 8
                                        .sp, // Assuming .sp is handled correctly in your project
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () =>
                                    AppRoutes.navigateToExploreNowScreen(
                                        context),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0.h,
                                      right:
                                          16.0.h), // u know the margin my fav
                                  child: Stack(
                                    clipBehavior: Clip
                                        .none, // this prevents clipping of positioned children outside the stack
                                    children: [
                                      Text('Explore now',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            decoration: TextDecoration
                                                .none, // no default underline
                                          )),
                                      Positioned(
                                        bottom:
                                            -2, // the position for the underlune
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height:
                                              2, // the thickness of the underline
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        // setup position blue x button
                        height: 180.h,
                        width: 100.h,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                iconSize: 20,
                                icon: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Image.asset(xButtonIcon),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = false;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: 20.0.h, top: 20.0.w),
                              child: SizedBox(
                                height: 100.h,
                                width: 80.w,
                                child: Image.asset(adventureIcon),
                              ),
                            )
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
