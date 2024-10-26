// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:TravelGo/Widgets/Screens/App/categories.dart';
import 'package:TravelGo/Widgets/Screens/App/comments.dart';
import 'package:TravelGo/Widgets/Screens/App/searchMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/vehicleAvailability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/flights.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InformationScreen extends StatefulWidget {
  final int text;
  final String? name;
  const InformationScreen({
    super.key,
    required this.text,
    this.name,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _searchController = TextEditingController();
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food_place.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String festivalIcon = "assets/images/icon/food.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  String? email;
  String? userEmail;
  String? description;
  String? text;
  String? img;
  String? imgUrl;
  String? hasCar;
  String? imageUrl;
  String? comments;
  String? hasMotor;
  String? located;
  var id;
  String? availability;
  String? price;
  final data = Data();
  late Usersss users = Usersss();
  final supabase = Supabase.instance.client;
  bool _isRedirecting = false;
  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchSpecificData(widget.text);
    fetchWithoutFunct();
    _isRedirecting = true;
  }

  Future<void> fetchSpecificData(int name) async {
    try {
      final dataList = await data.fetchSpecificDataInSingle(name);

      if (dataList == null) {
        setState(() {
          _isRedirecting = false;
          description = "No description available";
        });
      } else {
        setState(() {
          _isRedirecting = false;
          description = dataList['description'];
          text = dataList['place_name'];
          imageUrl = dataList['image'].toString();
          hasCar = dataList['car_availability'].toString();
          hasMotor = dataList['tricycle_availability'].toString();
          located = dataList['locatedIn'];
          price = dataList['price'];
          availability = dataList['availability'];
        });
      }
    } catch (e) {
      setState(() {
        description = "Error fetching data";
        _isRedirecting = false;
      });
      print('Error in fetchSpecificData: $e');
    } finally {
      setState(() {
        _isRedirecting = false;
      });
    }
  }

  Future<void> fetchWithoutFunct() async {
    final response = await users.fetchUserWithoutgetter();
    setState(() {
      imgUrl = response[0]['avatar_url'];
    });
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
          img = useremail[0]['avatar_url'].toString();
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 40.h, // making height reponsive
          leading: Builder(
            builder: (BuildContext context) => IconButton(
              icon: Icon(Icons.menu, size: 24.sp), // reponsive icon size
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: const DrawerMenuWidget(),
        body: _isRedirecting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  const Positioned(
                    child: Column(
                      children: <Widget>[
                        TitleMenu(),
                        SearchMenu(),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 160.h,
                        child: Container(
                          height: 300.sp,
                          width: 500.sp,
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
                        height: 390.h,
                        child: Container(
                          padding: EdgeInsets.only(left: 0, top: 30.h),
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w),
                                      child: Text(
                                        text ?? 'No data available',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        Icon(Icons.location_on,
                                            color: Colors.red, size: 20.sp),
                                        GestureDetector(
                                            onTap: () {
                                              AppRoutes.navigateToExploreMaPage(
                                                  context,
                                                  name: '$located',
                                                  id: widget.text);
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  located ?? 'I cant locate it',
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.blue),
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.map,
                                                  size: 10.sp,
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
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 30.w, right: 30.w),
                                      child: Text(
                                        description ?? 'No Description',
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    VehicleAvailability(
                                      text: widget.text,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 30.w),
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  'Explore Local Highlights: ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  'Nearby Hotels, Restaurants, and Events',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15.sp,
                                              ))
                                        ]))),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Categories(),
                                    ),
                                    SizedBox(height: 10.h),
                                    Comments(text: widget.text),
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        SizedBox(width: 25.w),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  'PHP ${price.toString()} - 6,000',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: '\nEstimated Expenses',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 13.sp))
                                        ])),
                                        Container(
                                          width: 160.w,
                                          padding: EdgeInsets.only(left: 50.w),
                                          child: BlueButtonWithoutFunction(
                                              text: Text(
                                                'See Tickets',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              oppressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Flight(
                                                              id: widget.text,
                                                            )));
                                              }),
                                        )
                                      ],
                                    )
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
              ));
  }
}
