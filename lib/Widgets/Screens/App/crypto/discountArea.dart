// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:itransit/Controllers/NetworkImages/food_area.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Widgets/Drawer/drawerMenu.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/VoucherButton.dart';

// ignore: must_be_immutable
class discountArea extends StatelessWidget {
  const discountArea({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel',
      home: discountAreaScreen(),
    );
  }
}

// ignore: must_be_immutable
class discountAreaScreen extends StatefulWidget {
  @override
  State<discountAreaScreen> createState() => _discountAreaScreenState();
}

// ignore: camel_case_types
class _discountAreaScreenState extends State<discountAreaScreen> {
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";

  String? email;
  String? img;

  var amenities = <String, dynamic>{};
  var imageUrlForAmenities = <String, dynamic>{};
  final data = FoodAreaBackEnd();

  final _searchController = TextEditingController();
  late Usersss users = Usersss();

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
        email = "error: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
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
                return Stack(children: [
                  Positioned.fill(
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
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, top: 20, bottom: 20),
                              height: 225,
                              width: 350,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(241, 252, 255, 100),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                '$img'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Spend wise and use',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: Color.fromRGBO(
                                                  5, 103, 180, 100),
                                            ),
                                          ),
                                          Text(
                                            // ignore: unnecessary_null_comparison
                                            email != null
                                                ? '$email'
                                                : 'Loading...',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    height: 70,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                            width: 30,
                                            child: FaIcon(
                                              FontAwesomeIcons.coins,
                                              color: Colors.yellow,
                                            )),
                                        Container(
                                          width: 280,
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Travel Go Points',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: null,
                                                    child: const Row(
                                                      children: [
                                                        Text(
                                                          '56.04',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' as of Sept 17',
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Row(
                                                children: [
                                                  SizedBox(
                                                    width: 269,
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: 0.56,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      color: Colors.yellow,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Row(
                                                children: [
                                                  Text(
                                                    'Earn 1,000 points and enjoy PHP100 discount on your next booking! \nStart collecting points now and save big!',
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      color: Color.fromRGBO(
                                                          5, 103, 180, 100),
                                                    ),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              width: 400,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Available Vouchers',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  VoucherButton(
                                      voucherTitle:
                                          'Enjoy up to 10% off at The Monarch Hotel!',
                                      description:
                                          'Book now and experience luxury at a discounted rate',
                                      expiring: '8 hours left',
                                      image: const AssetImage(
                                          'assets/images/icon/beach.png'),
                                      oppressed: () => 'Test')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]);
              }
            }));
  }
}
