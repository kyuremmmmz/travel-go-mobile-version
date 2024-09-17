// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itransit/Controllers/BookingBackend/hotel_booking.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Textfield/inputTextField.dart';
import 'package:itransit/Widgets/Textfield/phoneNumber.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final _checkOutController = TextEditingController();
  final _originController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _specialReqController = TextEditingController();
  final _validator = GlobalKey<FormState>();
  final _hotel = TextEditingController();
  final _number_of_children = TextEditingController();
  final _number_of_adult = TextEditingController();
  String? email;
  String? place;
  final bool _isWaiting = true;
  var amount;

  String? hotel;
  late Usersss users = Usersss();
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";
  final String suitcaseIcon = "assets/images/icon/suitcase.png";
  final String planeTicketIcon = "assets/images/icon/plane-ticket.png";
  bool _value = false;
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
    _hotel.dispose();
    _number_of_adult.dispose();
    _number_of_children.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchString(widget.id);
    fethHotel(widget.id);
    fetchEwan(widget.id);
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
      String datas = data!['hotel_price'];
      amount = datas.replaceAll(',', '');
    });
  }

  Future<void> fethHotel(
    int id,
  ) async {
    final data = await booking.passTheHotelData(id);
    setState(() {
      hotel = data!['hotel_name'];
      _hotel.text = hotel ?? '';
    });
  }

  Future<void> fetchEwan(
    int id,
  ) async {
    final data = await booking.passTheHotelData(id);
    setState(() {
      place = data!['hotel_located'];
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

  Future<void> checkout() async {
    final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(21000));
    if (picked != null) {
      setState(() {
        _checkOutController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> niggaModal(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: null,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: null,
                  child: const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.mobile_friendly_rounded),
                  title: const Text('Pay Online'),
                  onTap: () {
                    setState(() {
                      _paymentMethodController.text = "Pay Online";
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share_arrival_time),
                  title: const Text('Pay Upon Arrival'),
                  onTap: () {
                    setState(() {
                      _paymentMethodController.text = "Pay Upon Arrival";
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
            padding: null,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: null,
                  child: const Text(
                    'Room Type',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.medal,
                    color: Colors.amber,
                  ),
                  title: const Text('Deluxe Suite'),
                  onTap: () {
                    setState(() {
                      _vehicleTypeController.text = "Deluxe Suite";
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  leading:
                      const Icon(FontAwesomeIcons.crown, color: Colors.amber),
                  title: const Text('Premiere Suite '),
                  onTap: () {
                    setState(() {
                      _vehicleTypeController.text = "Premiere Suite ";
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.gem,
                    color: Colors.green,
                  ),
                  title: const Text('Executive Suite '),
                  onTap: () {
                    setState(() {
                      _vehicleTypeController.text = "Executive Suite ";
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.diamond,
                    color: Colors.blueAccent,
                  ),
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
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(226, 63, 176, 241),
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
                              icon: const Icon(FontAwesomeIcons.person),
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
                              icon: const Icon(FontAwesomeIcons.envelope),
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
                            child: PhonenumberTextField(
                              text: 'Phone Number:',
                              controller: _numberController,
                              icon: const Icon(FontAwesomeIcons.phone),
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
                              icon: const Icon(FontAwesomeIcons.hotel),
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
                            child: PhonenumberTextField(
                              icon: const Icon(FontAwesomeIcons.children),
                              controller: _number_of_children,
                              text: 'Number of children:',
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
                            child: PhonenumberTextField(
                              icon: const Icon(FontAwesomeIcons.peopleGroup),
                              controller: _number_of_adult,
                              text: 'Number of Adults:',
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.toString().isEmpty ||
                                      value.length <= 5) {
                                    return 'Please select Check in Date';
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.toString().isEmpty ||
                                      value.length <= 5) {
                                    return 'Please Select check out date';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                controller: _checkOutController,
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
                                  checkout();
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
                            child: inputTextField(
                              colorr: Colors.black,
                              text: 'Special Requests: (Optional)',
                              controller: _originController,
                            ),
                          ),
                          const SizedBox(
                            height: 0,
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
                                  value: _value,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _value = value ?? false;
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
                                        width: 150,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue),
                                            onPressed: _value
                                                ? () {
                                                    if (_validator.currentState!
                                                            .validate() ||
                                                        _paymentMethodController
                                                                .text
                                                                .trim() ==
                                                            "Pay Online") {
                                                      HotelBooking()
                                                          .insertBooking(
                                                        _nameController.text
                                                            .trim(),
                                                        _emailController.text
                                                            .trim(),
                                                        int.parse(
                                                            _numberController
                                                                .text
                                                                .trim()),
                                                        _hotel.text.trim(),
                                                        _checkInController.text
                                                            .trim(),
                                                        _checkOutController.text
                                                            .trim(),
                                                        _paymentMethodController
                                                            .text
                                                            .trim(),
                                                        _isWaiting
                                                            ? "Not Paid"
                                                            : "Paid",
                                                        int.parse(
                                                            _number_of_adult
                                                                .text
                                                                .trim()),
                                                        int.parse(
                                                            _number_of_children
                                                                .text
                                                                .trim()),
                                                        _vehicleTypeController.text.trim(),
                                                        int.parse(amount),
                                                      );
                                                      AppRoutes
                                                          .navigateToLinkedBankAccount(
                                                        context,
                                                        name: _nameController
                                                            .text
                                                            .trim(),
                                                        phone: int.parse(
                                                            _numberController
                                                                .text
                                                                .trim()),
                                                        nameoftheplace: '',
                                                        price:
                                                            int.parse(amount),
                                                        payment:
                                                            int.parse(amount),
                                                        hotelorplace: place ?? '',
                                                      );
                                                    } else {
                                                      AppRoutes
                                                          .navigateToOrderReceipt(
                                                              context);
                                                    }
                                                  }
                                                : null,
                                            child: const Text(
                                              'Place Booking',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )),
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
