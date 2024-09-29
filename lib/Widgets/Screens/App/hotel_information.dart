// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itransit/Controllers/BookingBackend/hotel_booking.dart';
import 'package:itransit/Controllers/NetworkImages/hotel_images.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Controllers/SearchController/searchController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelInformationScreen extends StatefulWidget {
  final int text;
  final String? name;
  final int id;
  const HotelInformationScreen({
    super.key,
    required this.text,
    this.name,
    required this.id,
  });

  @override
  State<HotelInformationScreen> createState() => _HotelInformationScreenState();
}

class _HotelInformationScreenState extends State<HotelInformationScreen> {
  final _searchController = TextEditingController();
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  String? email;
  String? description;
  String? text;
  String? hasCar;
  String? imageUrl;
  String? hasMotor;
  String? located;
  String? availability;
  var price;
  var id;
  var amenities = <String, dynamic>{};
  var imageUrlForAmenities = <String, dynamic>{};
  final data = HotelImages();
  late Usersss users = Usersss();

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchSpecificData(widget.text);
  }

  Future<void> _isRedirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

  Future<void> fetchSpecificData(int id) async {
    try {
      final dataList = await data.fetchDataInSingle(id);

      if (dataList == null) {
        setState(() {
          description = "No description available";
        });
      } else {
        setState(() {
          description = dataList['hotel_description'];
          text = dataList['hotel_name'];
          id = dataList['id'];
          imageUrl = dataList['image'].toString();
          hasCar = dataList['car_availability'].toString();
          hasMotor = dataList['tricycle_availability'].toString();
          located = dataList['hotel_located'];
          price = dataList['hotel_price'];
          availability = dataList['availability'];
          for (var i = 1; i <= 20; i++) {
            final key = 'amenity$i';
            final keyUrl = 'amenity${i}Url';
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<String?> getter(String image) async {
    final response =
        supabase.storage.from('hotel_amenities_url').getPublicUrl(image);
    if (response.isEmpty) {
      return 'null';
    }
    return response;
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
        email = "Error: $e";
      });
    }
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
                    Positioned(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'TRAVEL GO',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: const Offset(3.0, 3.0),
                                  blurRadius: 4.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "Northwestern part of Luzon Island, Philippines",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  hintStyle: TextStyle(color: Colors.black54),
                                  hintText: 'Search Destination',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    borderSide:
                                        BorderSide(color: Colors.black54),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
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
                                  title:
                                      Text(suggestion['title'] ?? 'No title'),
                                  subtitle: Text(
                                      suggestion['address'] ?? 'No address'),
                                );
                              },
                              onSuggestionSelected: (dynamic suggestion) {
                                _searchController.text =
                                    suggestion['title'] ?? 'No title';
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 160,
                          child: Container(
                            height: 300,
                            width: 500,
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
                          height: 390,
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
                                          child: GestureDetector(
                                            onTap: () {
                                              AppRoutes.navigateToTesting(
                                                  context,
                                                  name: '$text',
                                                  id: widget.id);
                                            },
                                            child: Text(
                                              text ?? 'No data available',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          Text(located ?? 'I cant locate it')
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: const Text(
                                          'About',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Text(
                                          description ?? 'No Description',
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 250),
                                        child: const Text(
                                          'Amenities',
                                          style: TextStyle(
                                              fontSize: 20,
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
                                                    height: 150,
                                                    width: 350,
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
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    'PHP ${price.toString()} - 6,000',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const TextSpan(
                                                text: '\nEstimated Expenses',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 13))
                                          ])),
                                          Container(
                                            width: 200,
                                            padding:
                                                const EdgeInsets.only(left: 50),
                                            child: BlueButtonWithoutFunction(
                                                text: const Text(
                                                  'Place Booking',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                oppressed: () {
                                                  HotelBooking()
                                                      .passTheHotelData(
                                                          widget.text);
                                                  AppRoutes
                                                      .navigateToHotelBookingScreen(
                                                          context,
                                                          id: widget.text);
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
                );
              }
            }));
  }
}
