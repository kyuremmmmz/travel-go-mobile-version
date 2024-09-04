import 'package:flutter/material.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Textfield/inputTextField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(const BookingArea());
}

class BookingArea extends StatelessWidget {
  const BookingArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel',
      home: BookingAreaScreen(),
    );
  }
}

class BookingAreaScreen extends StatefulWidget {
  const BookingAreaScreen({super.key});

  @override
  State<BookingAreaScreen> createState() => _BookingAreaScreenState();
}

class _BookingAreaScreenState extends State<BookingAreaScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _destinationController = TextEditingController();
  final _departureController = TextEditingController();
  final _originController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _specialReqController = TextEditingController();
  String? email;
  late Usersss users = Usersss();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _destinationController.dispose();
    _departureController.dispose();
    _originController.dispose();
    _vehicleTypeController.dispose();
    _specialReqController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
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
                    backgroundImage: AssetImage(
                        'assets/images/icon/beach.png'), // Replace with your own profile image
                    radius: 40,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // ignore: unnecessary_null_comparison
                    email != null ? '$email' : 'Hacked himala e',
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
      body: Stack(
        children: [
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
                  style: TextStyle(fontSize: 16), // Adjust text style as needed
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Scrollbar(
                    child: Positioned(
                        bottom: 0,
                        child: Container(
                          height: 500,
                          width: 410,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              // ignore: sized_box_for_whitespace
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: inputTextField(
                                    colorr: Colors.black,
                                    text: 'Full Name',
                                    controller: _nameController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: inputTextField(
                                    colorr: Colors.black,
                                    text: 'Email Address',
                                    controller: _emailController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: inputTextField(
                                    colorr: Colors.black,
                                    text: 'Phone Number',
                                    controller: _numberController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: inputTextField(
                                    colorr: Colors.black,
                                    text: 'Destination',
                                    controller: _destinationController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: inputTextField(
                                    colorr: Colors.black,
                                    text: 'Departure Date',
                                    controller: _departureController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: inputTextField(
                                    colorr: Colors.black,
                                    text: 'Origin',
                                    controller: _originController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child:
                                        DropdownButtonFormField(items: const [
                                      DropdownMenuItem(
                                        value: "-1",
                                        child: Text("Payment Method"),
                                      ),
                                      DropdownMenuItem(
                                        value: "1",
                                        child: Text("Paypal"),
                                      ),
                                      DropdownMenuItem(
                                        value: "2",
                                        child: Text("GCash"),
                                      ),
                                    ], onChanged: (value) {})),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: inputTextField(
                                    colorr: Colors.black,
                                    text: 'Vehicle Type: (Optional)',
                                    controller: _vehicleTypeController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 350,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: inputTextField(
                                    colorr: Colors.black,
                                    text: 'Special Requests: (Optional)',
                                    controller: _specialReqController,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
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

class DismissableFindMoreLocation extends StatefulWidget {
  const DismissableFindMoreLocation({super.key});

  @override
  _DismissableFindMoreLocationState createState() =>
      _DismissableFindMoreLocationState();
}

class _DismissableFindMoreLocationState
    extends State<DismissableFindMoreLocation> {
  bool _isVisible = true;
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Center(
            child: Container(
              height: 180,
              width: 380,
              decoration: const BoxDecoration(
                color: Colors.blue,
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
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '  Find more location\n  around you',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '    Find your next adventure around Pangasinan \n    and create unforgettable memories!',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () =>
                                    AppRoutes.navigateToExploreNowScreen(
                                        context),
                                child: Stack(
                                  children: [
                                    const Text(
                                      '    Explore now',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        decoration: TextDecoration
                                            .none, // Disable the default underline
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 10,
                                      right: 0,
                                      child: Container(
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: 100,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                iconSize: 20,
                                icon: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(xButtonIcon),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset(adventureIcon),
                            ),
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
