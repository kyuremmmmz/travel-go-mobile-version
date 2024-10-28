// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Widgets/Screens/App/searchMenu.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:TravelGo/Controllers/NetworkImages/food_area.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import '../ResponsiveScreen/ResponsiveScreen.dart';

// ignore: must_be_immutable
class FoodAreaInfo extends StatefulWidget {
  String? name;
  int id;
  FoodAreaInfo({
    super.key,
    this.name,
    required this.id,
  });

  @override
  State<FoodAreaInfo> createState() => _FoodAreaInfoState();
}

class _FoodAreaInfoState extends State<FoodAreaInfo> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";

  String? email;
  String? description;
  String? placeName;
  String? imageUrl;
  var id;
  String? located;
  String? foodName;
  String? price;
  var amenities = <String, dynamic>{};
  var imageUrlForAmenities = <String, dynamic>{};
  final data = FoodAreaBackEnd();

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
    final datas = await data.getFood();
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
          description = dataList['description'];
          foodName = dataList['img'];
          imageUrl = dataList['imgUrl'].toString();

          located = dataList['located'];
          id = dataList['id'];
          price = dataList['price'];
          for (var i = 1; i <= 20; i++) {
            final key = 'dine$i';
            final keyUrl = 'dineUrl$i';
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
        appBar: AppBar(
          toolbarHeight: 40.h,
          leading: Builder(
            builder: (BuildContext context) => IconButton(
              icon: Icon(Icons.menu, size: 24.sp),
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
                        children: <Widget>[TitleMenu(), SearchMenu()],
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: Responsive().infoSizePictureTop(),
                          child: Container(
                            height: Responsive().infoSizePictureHeight(),
                            width: Responsive().infoSizePictureWidth(),
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
                          top: Responsive().scrollableContainerInfoTop(),
                          child: Container(
                            padding: Responsive().containerPaddingTop(),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: Responsive().borderRadiusTop(),
                            ),
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: Responsive().horizontalPadding(),
                                      child: Text(
                                        foodName ?? 'No data available',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Responsive().titleFontSize(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 25.w),
                                        Icon(Icons.location_on,
                                            color: Colors.red,
                                            size:
                                                Responsive().headerFontSize()),
                                        GestureDetector(
                                            onTap: () {
                                              AppRoutes.navigateToTesting(
                                                  context,
                                                  name: '$located',
                                                  id: id);
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  located ?? 'I cant locate it',
                                                  style: TextStyle(
                                                      fontSize: Responsive()
                                                          .aboutFontSize(),
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.blue),
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.map,
                                                  size: Responsive()
                                                      .clickToOpenFontSize(),
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 30.w),
                                      child: Text(
                                        'About',
                                        style: TextStyle(
                                            fontSize:
                                                Responsive().headerFontSize(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: Responsive().horizontalPadding(),
                                      child: Text(
                                        description ?? 'No Description',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize:
                                                Responsive().aboutFontSize()),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 30.w),
                                      child: Text(
                                        'Accomodations',
                                        style: TextStyle(
                                            fontSize:
                                                Responsive().headerFontSize(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Column(
                                        children: imageUrlForAmenities.entries
                                            .map((entry) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 20.h),
                                          Stack(
                                            children: [
                                              Container(
                                                  height: Responsive()
                                                      .amenitiesBoxHeight(),
                                                  width: Responsive()
                                                      .amenitiesBoxWidth(),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            entry.value ?? ''),
                                                      ),
                                                      color: Colors.blue,
                                                      borderRadius: Responsive()
                                                          .amenitiesBorderRadius())),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.all(10.sp),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.12),
                                                      borderRadius: Responsive()
                                                          .amenitiesTextBorderRadius()),
                                                  child: Text(
                                                    amenities[entry.key] ?? '',
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    }).toList()),
                                    SizedBox(height: 20.h),
                                  ],
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
