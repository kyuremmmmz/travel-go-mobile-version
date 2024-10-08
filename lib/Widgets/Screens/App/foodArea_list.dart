import 'package:flutter/material.dart';
import 'package:itransit/Controllers/NetworkImages/food_area.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Screens/App/categories.dart';
import 'package:itransit/Widgets/Screens/App/foodAreaAbout.dart';
import 'package:itransit/Widgets/Screens/App/titleSearchMenu.dart';
import 'package:itransit/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

class FoodArea extends StatefulWidget {
  const FoodArea({super.key});

  @override
  State<FoodArea> createState() => _FoodAreaState();
}

class _FoodAreaState extends State<FoodArea> {
  late String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  late String manaoag = "assets/images/places/Manaoag.jpg";
  String? email;
  late Usersss users = Usersss();
  late FoodAreaBackEnd images = FoodAreaBackEnd();
  List<Map<String, dynamic>> data = [];

  Future<void> redirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

  Future<void> places() async {
    final datas = await images.getFood();
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
                      backgroundImage:
                          AssetImage('assets/images/icon/beach.png'),
                      radius: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      email ?? 'Hacked himala e',
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
                  AppRoutes.navigateToMainMenu(context);
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
                    const TitleSearchMenu(),
                    const SizedBox(height: 30),
                    Expanded(
                        child: Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(children: <Widget>[
                                  const Categories(),
                                  SizedBox(height: 20.h),
                                  Container(
                                    padding: EdgeInsets.only(right: 205.w, bottom: 5.h),
                                    child: Text(
                                      'Food Places',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 49, 49, 49),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Column(
                                    children: data.map((place) {
                                      final imageUrl = place['imgUrl'];
                                      final text = place['img'] ?? 'Unknown';
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final placeData =
                                                  await FoodAreaBackEnd()
                                                      .getSpecificData(
                                                          place['id']);
                                              if (placeData != null) {
                                                Navigator.push(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FoodAreaAboutScreen(
                                                            id: place['id'],
                                                          )),
                                                );
                                              }
                                            },
                                            child: Stack( // area of the food places
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
                                                      Radius.circular(15.w), // radius area of hotels images 
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(
                                                            10.w),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.12),
                                                      borderRadius:
                                                          BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(30.w),
                                                        bottomRight:
                                                            Radius.circular(30.w),
                                                      ),
                                                    ),
                                                    child: Text( // color area of text in each hotels.
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
                                          const SizedBox(height: 20),
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
