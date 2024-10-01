// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itransit/Controllers/BookingBackend/hotel_booking.dart';
import 'package:itransit/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Controllers/SearchController/searchController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:itransit/Widgets/Drawer/drawerMenu.dart';
import 'package:itransit/Widgets/Screens/App/exploreNow.dart';
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
  var id;
  String? availability;
  String? price;
  final data = Data();
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

  Future<void> fetchSpecificData(int name) async {
    try {
      final dataList = await data.fetchSpecificDataInSingle(name);

      if (dataList == null) {
        setState(() {
          description = "No description available";
        });
      } else {
        setState(() {
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
      });
      print('Error in fetchSpecificData: $e');
    }
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
                                        child: Text(
                                          text ?? 'No data available',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                AppRoutes.navigateToTesting(
                                                    context,
                                                    name: '$located',
                                                    id: id);
                                              },
                                              child: Text(located ??
                                                  'I cant locate it'))
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
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 170),
                                        child: const Text(
                                          'Vehicle Availability',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                BlueIconButtonDefault(
                                                  image:
                                                      'assets/images/icon/tricycle.png',
                                                  oppressed: () =>
                                                      print('Hotels clicked'),
                                                ),
                                                const CategoryLabel(
                                                    label: 'Tricycle'),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                BlueIconButtonDefault(
                                                  image:
                                                      'assets/images/icon/motorbike.png',
                                                  oppressed: () => print(
                                                      'Food Place clicked'),
                                                ),
                                                CategoryLabel(
                                                    label: hasMotor == "true"
                                                        ? 'Motorcycle'
                                                        : 'Unavailable'),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                BlueIconButtonDefault(
                                                  image:
                                                      'assets/images/icon/plane.png',
                                                  oppressed: () =>
                                                      print('Beaches clicked'),
                                                ),
                                                const CategoryLabel(
                                                    label: 'Planes'),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                BlueIconButtonDefault(
                                                  image:
                                                      'assets/images/icon/bus.png',
                                                  oppressed: () => print(
                                                      'Festivals clicked'),
                                                ),
                                                CategoryLabel(
                                                    label: hasCar == "true"
                                                        ? "Bus or Van"
                                                        : "No van or bus available"),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(right: 60),
                                          child: RichText(
                                              text: const TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    'Explore Local Highlights: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    'Nearby Hotels,\nRestaurants, and Events',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 15,
                                                ))
                                          ]))),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            children: [
                                              BlueIconButtonDefault(
                                                image: beachIcon,
                                                oppressed: () =>
                                                    print('Hotels clicked'),
                                              ),
                                              const CategoryLabel(
                                                  label: 'Hotels'),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
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
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              BlueIconButtonDefault(
                                                image: beachIcon,
                                                oppressed: () =>
                                                    print('Beaches clicked'),
                                              ),
                                              const CategoryLabel(
                                                  label: 'Beaches'),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              BlueIconButtonDefault(
                                                image: hotelIcon,
                                                oppressed: () =>
                                                    print('Festivals clicked'),
                                              ),
                                              const CategoryLabel(
                                                  label:
                                                      'Festivals and \nEvents'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 35),
                                              child: const Row(
                                                children: [
                                                  Text(
                                                      '4.9/5',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 49, 49, 49),
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'OUT OF 5',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 49, 49, 49),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                ],
                                              )
                                            ),
                                            const SizedBox(
                                              width: 80,
                                            ),
                                            const Icon(Icons.star,
                                                color: Colors.yellow, size: 25),
                                            const Icon(Icons.star,
                                                color: Colors.yellow, size: 25),
                                            const Icon(Icons.star,
                                                color: Colors.yellow, size: 25),
                                            const Icon(Icons.star,
                                                color: Colors.yellow, size: 25),
                                            const Icon(Icons.star_half_outlined,
                                                color: Colors.yellow, size: 25)
                                          ]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SingleChildScrollView(
                                            child: Container(
                                              width: 350,
                                              height: 350,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    255, 203, 231, 255),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                top: 15),
                                                        child: const Text(
                                                          '2 Comments',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      44,
                                                                      44,
                                                                      44),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 60,
                                                      ),
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20,
                                                                  top: 15),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showAdaptiveDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return const AlertDialog(
                                                                    title: Text('Rate and review ',
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.bold
                                                                    )),
                                                                    backgroundColor: Colors.blue,

                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: const Text(
                                                              'Write a comment',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
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
                                            width: 180,
                                            padding:
                                                const EdgeInsets.only(left: 50),
                                            child: BlueButtonWithoutFunction(
                                                text: const Text(
                                                  'Book Now',
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
                                                      .passtheData(widget.text);
                                                  AppRoutes
                                                      .navigateToBookingArea(
                                                          context,
                                                          id: widget.text);
                                                        }
                                                      ),
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
                      }
                    )
                  );
                }
              }
