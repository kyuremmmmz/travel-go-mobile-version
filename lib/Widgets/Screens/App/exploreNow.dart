import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/SearchController/searchController.dart';
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
              }  else if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: Text(
                    'No internet connection',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                );
              }
              else {
                return Stack(children: [
                  Positioned.fill(
                      child: Column(children: <Widget>[
                  Text(
                    'TRAVEL GO', // The home Travel Go Icon DITO HA
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: Color(0xFF44CAF9),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0.h, -2.0.h), // Position of the shadow (x, y)
                            blurRadius: 20, // Blur effect of the shadow
                            color: Color.fromARGB(128, 117, 116, 116), // Shadow color with opacity
                                 ),
                                ],
                                ),
                              ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 59.0.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 12.h),
                            Image.asset(
                              'assets/images/icon/placeholder.png',
                              width: 13.w,
                              height: 13.h,
                            ),
                            SizedBox(height: 30.h,),
                          ],
                        ),
                        SizedBox(width: 5.w),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 12.h),
                            Text(
                              "Northwestern part of Luzon Island, Philippines",
                              style: TextStyle(fontSize: 11.sp),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ],
                      ), 
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: 25.h),
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _searchController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.h, horizontal: 10.h),
                            hintStyle: TextStyle(color: Colors.black54),
                            hintText: 'Search Destination',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.h)),
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.h)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await Searchcontroller()
                              .fetchSuggestions(pattern);
                        },
                        itemBuilder: (context, dynamic suggestion) {
                          return ListTile(
                            title: Text(suggestion['title'] ?? 'No title'),
                            subtitle:
                                Text(suggestion['address'] ?? 'No address'),
                          );
                        },
                        onSuggestionSelected: (dynamic suggestion) {
                          _searchController.text =
                              suggestion['title'] ?? 'No title';
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
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
                                              image: beachIcon,
                                              oppressed: () => print('helo')),
                                          const CategoryLabel(label: 'Hotels'),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          BlueIconButtonDefault(
                                            image: foodIcon,
                                            oppressed: () =>
                                                print('Food Place clicked'),
                                          ),
                                          const CategoryLabel(
                                              label: 'Food Place'),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          BlueIconButtonDefault(
                                            image: beachIcon,
                                            oppressed: () =>
                                                print('Beaches clicked'),
                                          ),
                                          const CategoryLabel(label: 'Beaches'),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          BlueIconButtonDefault(
                                            image: hotelIcon,
                                            oppressed: () =>
                                                print('Festivals clicked'),
                                          ),
                                          const CategoryLabel(
                                              label: 'Festivals and \nEvents'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 220
                                    ),
                                    child: const Text(
                                      'Popular Places',
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 49, 49, 49),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    children: place.map((place) {
                                      final imageUrl = place['image'];
                                      final text = place['place_name'] ?? 'Unknown';
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
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    width: 600,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(imageUrl),
                                                      ),
                                                      color: Colors.blue,
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(30),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black.withOpacity(0.12),
                                                        borderRadius: const BorderRadius.only(
                                                          bottomLeft: Radius.circular(30),
                                                          bottomRight: Radius.circular(30),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        text,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
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
                                ]
                              )
                            )
                          )
                        )
                      ]
                    )
                  )
                ]
              );
            }
          }
        )
      );
    }
  }

class CategoryLabel extends StatelessWidget {
  final String label;
  const CategoryLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: 50,
        child: Text(
          label,
          textAlign: TextAlign.center,
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
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: oppressed,
              child: const Text(
                'View all',
                style: TextStyle(
                  color: Color.fromRGBO(33, 150, 243, 100),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}