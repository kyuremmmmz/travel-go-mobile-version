import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/Searches/searchMenu.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/NetworkImages/hotel_images.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Widgets/Screens/App/categories.dart';
import 'package:TravelGo/Widgets/Screens/App/InfoScreens/HotelsInfo.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  late String manaoag = "assets/images/places/Manaoag.jpg";
  String? email;
  late Usersss users = Usersss();
  late HotelImages images = HotelImages();
  List<Map<String, dynamic>> data = [];
  bool isLoading = false;

  Future<void> redirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

  Future<void> places() async {
    final datas = await images.fetchHotels();
    setState(() {
      data = datas;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    places();
    isLoading = true;
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
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Stack(children: [
                Positioned.fill(
                    child: Column(children: <Widget>[
                  const TitleMenu(),
                  const SearchMenu(),
                  SizedBox(height: 30.h),
                  Expanded(
                      child: Scrollbar(
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: Column(children: <Widget>[
                                Categories(
                                  category: 'hotel',
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 190.w, bottom: 5.h),
                                  child: Text(
                                    'Popular Hotels',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(255, 49, 49, 49),
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
                                        place['hotel_name'] ?? 'Unknown';
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            final placeData =
                                                await HotelImages()
                                                    .fetchDataInSingle(
                                                        place['id']);
                                            if (placeData != null) {
                                              Navigator.push(
                                                // ignore: use_build_context_synchronously
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HotelsInfo(
                                                          text: place['id'],
                                                          name: place[
                                                              'hotel_name'],
                                                          id: place['id'],
                                                        )),
                                              );
                                            }
                                          },
                                          child: Stack(
                                            // area of the popular hotels images
                                            children: [
                                              Container(
                                                height: 150.h,
                                                width: 600.w,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        NetworkImage(imageUrl),
                                                  ),
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15
                                                        .w), // radius area of hotels images
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: EdgeInsets.all(10.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.12),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(30.w),
                                                      bottomRight:
                                                          Radius.circular(30.w),
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
              ]));
  }
}
