// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itransit/Controllers/BookingBackend/hotel_booking.dart';
import 'package:itransit/Widgets/Textfield/dropDownTextField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/Widgets/Textfield/inputTextField.dart';

class BookingArea extends StatelessWidget {
  final int id;
  const BookingArea({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Go',
      home: BookingAreaScreen(id: id),
    );
  }
}

class BookingAreaScreen extends StatefulWidget {
  final int id;
  const BookingAreaScreen({super.key, required this.id});

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
  final _paymentMethodController = TextEditingController();
  final _specialReqController = TextEditingController();
  String? email;
  // ignore: prefer_typing_uninitialized_variables
  var amount;
  late Usersss users = Usersss();
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";
  final String suitcaseIcon = "assets/images/icon/suitcase.png";
  final String planeTicketIcon = "assets/images/icon/plane-ticket.png";
  bool value = false;
  HotelBooking booking = HotelBooking();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _destinationController.dispose();
    _departureController.dispose();
    _originController.dispose();
    _paymentMethodController.dispose();
    _vehicleTypeController.dispose();
    _specialReqController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchString(widget.id);
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

  Future<void> fetchString(int id) async {
    final data = await booking.passtheData(id);
    setState(() {
      amount = data!['price'];
    });
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
            Column(
              children: <Widget>[
                const Text(
                  'TRAVEL GO',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Northwestern part of Luzon Island, Philippines",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity, // Adjust width as needed
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, right: 10),
                                child: IconButton(
                                  iconSize: 20,
                                  icon: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(xButtonIcon),
                                  ),
                                  onPressed:
                                      () {}, // change routes to InformationScreen later
                                ),
                              ),
                            ),
                            const Text(
                              'Flight Booking Form',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Simply enter your travel details, choose your preferred flight, and secure your seat to start your journey.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 82, 79, 79),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: inputTextField(
                                colorr: Colors.black,
                                text: 'Full Name:',
                                controller: _nameController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: inputTextField(
                                colorr: Colors.black,
                                text: 'Email Address:',
                                controller: _emailController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: inputTextField(
                                colorr: Colors.black,
                                text: 'Phone Number:',
                                controller: _numberController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: inputTextField(
                                colorr: Colors.black,
                                text: 'Destination:',
                                controller: _destinationController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: inputTextField(
                                colorr: Colors.black,
                                text: 'Departure Date:',
                                controller: _departureController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: inputTextField(
                                colorr: Colors.black,
                                text: 'Origin:',
                                controller: _originController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: dropDownTextField(
                                colorr: Colors.black,
                                text: 'Vehicle Type:',
                                controller: _vehicleTypeController,
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: inputTextField(
                                colorr: Colors.black,
                                text: 'Payment Method:',
                                controller: _paymentMethodController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: inputTextField(
                                colorr: Colors.black,
                                text: 'Special Requests: (Optional)',
                                controller: _specialReqController,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Theme(
                              data: ThemeData(
                                checkboxTheme: const CheckboxThemeData(
                                  shape: CircleBorder(),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: ListTileTheme(
                                  horizontalTitleGap: 0.0,
                                  child: CheckboxListTile(
                                    activeColor: Colors.green,
                                    title: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                          text:
                                              "I have reviewed my booking details and agree to the ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: "Terms of Service.",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => AppRoutes
                                                .navigateToForgotPassword(
                                                    context),
                                        ),
                                      ]),
                                    ),
                                    value: value,
                                    onChanged: (value) {
                                      setState(() {
                                        this.value = value!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              width: double.infinity, // Adjust width as needed
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 30),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: Image.asset(adventureIcon),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          child: Image.asset(suitcaseIcon),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: Image.asset(planeTicketIcon),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          const Row(
                                            children: [
                                              Text(
                                                "Total Amount",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 26, 169, 235),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'PHP $amount',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: BlueButtonWithoutFunction(
                                            text: const Text(
                                              'Place Flight',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 26, 169, 235)),
                                            oppressed: () {
                                              AppRoutes.navigateToOrderReceipt(
                                                  context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
