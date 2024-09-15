// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itransit/Controllers/BookingBackend/hotel_booking.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/Widgets/Textfield/inputTextField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelBookingArea extends StatelessWidget {
  final int id;
  const HotelBookingArea({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Go',
      home: HotelBookingAreaScreen(
        id: id,
      ),
    );
  }
}

class HotelBookingAreaScreen extends StatefulWidget {
  final int id;
  const HotelBookingAreaScreen({super.key, required this.id});

  @override
  State<HotelBookingAreaScreen> createState() => _HotelBookingAreaScreenState();
}

class _HotelBookingAreaScreenState extends State<HotelBookingAreaScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _destinationController = TextEditingController();
  final _checkInController = TextEditingController();
  final _originController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _specialReqController = TextEditingController();
  final _validator = GlobalKey<FormState>();
  String? email;
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
    _checkInController.dispose();
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

  Future<void> fetchString(
    int id,
  ) async {
    final data = await booking.passTheHotelData(id);
    setState(() {
      amount = data!['hotel_price'];
    });
  }

  Future<void> setter() async {
    final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(21000));
    if (picked != null) {
      setState(() {
        _checkInController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> niggaModal(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Credit Card'),
                  onTap: () {
                    setState(() {
                      _paymentMethodController.text = "Credit Card";
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.paypal),
                  title: const Text('PayPal'),
                  onTap: () {
                    setState(() {
                      _paymentMethodController.text = "Paypal";
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> niggaModalRoomType(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                ListTile(
                  leading: const Icon(Icons.room_service),
                  title: const Text('Deluxe Suite'),
                  onTap: () {
                    setState(() {
                      _vehicleTypeController.text = "Deluxe Suite";
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.room_service),
                  title: const Text('Premiere Suite '),
                  onTap: () {
                    setState(() {
                      _vehicleTypeController.text = "Premiere Suite ";
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.room_service),
                  title: const Text('Executive Suite '),
                  onTap: () {
                    setState(() {
                      _paymentMethodController.text = "Executive Suite ";
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.room_service),
                  title: const Text('Presidential Suite'),
                  onTap: () {
                    setState(() {
                      _vehicleTypeController.text = "Presidential Suite";
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
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
                      email != null ? '$email' : 'Loading...',
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
        body: Form(
          key: _validator,
          child: Column(
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
                              padding: const EdgeInsets.only(top: 8, right: 10),
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
                            'Hotel Booking Form',
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  )
                                ]),
                            child: inputTextField(
                              validator: (value) {
                                if (value == null ||
                                    value.toString().isEmpty ||
                                    value.length <= 5) {
                                  return 'please enter your name';
                                }
                                return null;
                              },
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  )
                                ]),
                            child: inputTextField(
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'please enter valid email address';
                                }
                                return null;
                              },
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
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
                              text: 'Hotel:',
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
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                controller: _checkInController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText: 'Check In Date',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  prefixIcon:
                                      Icon(Icons.calendar_today_outlined),
                                ),
                                readOnly: true,
                                onTap: () {
                                  setter();
                                },
                              )),
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
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                controller: _originController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText: 'Check Out Date',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  prefixIcon:
                                      Icon(Icons.calendar_today_outlined),
                                ),
                                readOnly: true,
                                onTap: () {
                                  setter();
                                },
                              )),
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
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                controller: _paymentMethodController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText: 'Payment Method',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  prefixIcon: Icon(Icons.payment_rounded),
                                ),
                                readOnly: true,
                                onTap: () {
                                  niggaModal(context);
                                },
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 380,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  )
                                ]),
                            child: TextField(
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                controller: _vehicleTypeController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText: 'Room Type',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  prefixIcon: Icon(Icons.room_outlined),
                                ),
                                readOnly: true,
                                onTap: () {
                                  niggaModalRoomType(context);
                                },
                              )
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 380,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
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
                              controller: _originController,
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
                                            fontSize: 12, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: "Terms of Service.",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
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
                              padding: const EdgeInsets.only(left: 10, top: 30),
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
                                                  fontWeight: FontWeight.w700),
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
                                            'Place Booking',
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
                                            if (_validator.currentState!
                                                .validate()) {
                                              AppRoutes.navigateToOrderReceipt(
                                                  context);
                                            }
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
        ));
  }
}
