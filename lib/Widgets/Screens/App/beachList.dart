// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/NetworkImages/beach_images.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/InfoScreens/BeachInfo.dart';
import 'package:TravelGo/Widgets/Screens/App/categories.dart';
import 'package:TravelGo/Widgets/Screens/App/searchMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness
import 'package:supabase_flutter/supabase_flutter.dart';

class Beaches extends StatefulWidget {
  const Beaches({
    super.key,
  });

  @override
  State<Beaches> createState() => _BeachesState();
}

class _BeachesState extends State<Beaches> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  late String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  late String manaoag = "assets/images/places/Manaoag.jpg";
  String? email;
  late Usersss users = Usersss();
  late BeachImages images = BeachImages();
  List<Map<String, dynamic>> data = [];

  Future<void> redirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

  Future<void> places() async {
    final datas = await images.fetchBeaches();
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
        drawer: const DrawerMenuWidget(),
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
                    const TitleMenu(),
                    const SearchMenu(),
                    const SizedBox(height: 30),
                    Expanded(
                        child: Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Column(children: <Widget>[
                                  Categories(
                                    category: 'beach',
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 160.w, bottom: 5.h),
                                    child: Text(
                                      'Beach Destinations',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 49, 49, 49),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Column(
                                    children: data.map((place) {
                                      final imageUrl = place['image'];
                                      final text =
                                          place['beach_name'] ?? 'Unknown';
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final placeData =
                                                  await BeachImages()
                                                      .getSpecificData(
                                                          place['id']);
                                              if (placeData != null) {
                                                Navigator.push(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BeachInfo(
                                                            id: place['id'],
                                                            name: place[
                                                                'beach_name'],
                                                          )),
                                                );
                                              }
                                            },
                                            child: Stack(
                                              // area of the beach destinations
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
                                                      Radius.circular(15.w),
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
