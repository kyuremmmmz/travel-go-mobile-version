// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/BookingBackend/booking.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Textfield/inputTextField.dart';
import 'package:TravelGo/Widgets/Textfield/phoneNumber.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Confirmbooking extends StatelessWidget {
  final int id;
  final String name;
  final String email;
  final int phone;
  final int age;
  final String country;
  final int numberOfChildren;
  final int numberOfAdults;
  final String paymentMethod;
  final String? specialReq;
  final int price;
  final String last;

  const Confirmbooking({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.country,
    required this.numberOfChildren,
    required this.numberOfAdults,
    required this.paymentMethod,
    this.specialReq,
    required this.price,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel Go',
        home: ConfirmBookingAreaScreen(
          id: id,
          name: name,
          email: email,
          phone: phone,
          age: age,
          country: country,
          numberOfChildren: numberOfChildren,
          numberOfAdults: numberOfAdults,
          paymentMethod: paymentMethod,
          price: price,
          last: last,
        ));
  }
}

class ConfirmBookingAreaScreen extends StatefulWidget {
  final int id;
  final String name;
  final String last;
  final String email;
  final int phone;
  final int age;
  final String country;
  final int numberOfChildren;
  final int numberOfAdults;
  final String paymentMethod;
  final String? specialReq;
  final int price;
  const ConfirmBookingAreaScreen({
    super.key,
    required this.id,
    required this.name,
    required this.last,
    required this.email,
    required this.phone,
    required this.age,
    required this.country,
    required this.numberOfChildren,
    required this.numberOfAdults,
    required this.paymentMethod,
    this.specialReq,
    required this.price,
  });

  @override
  State<ConfirmBookingAreaScreen> createState() => _ConfirmBookingAreaScreen();
}

class _ConfirmBookingAreaScreen extends State<ConfirmBookingAreaScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _destinationController = TextEditingController();
  final _originController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _specialReqController = TextEditingController();
  final _validator = GlobalKey<FormState>();
  final _country = TextEditingController();
  final _hotel = TextEditingController();
  final _age = TextEditingController();
  final _lastNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final _number_of_children = TextEditingController();
  // ignore: non_constant_identifier_names
  final _number_of_adult = TextEditingController();
  String? email;
  String? place;
  final supabase = Supabase.instance.client;
  var amount = 0;
  String? strAmount;
  String? origin;
  String? destination;
  String? departure;
  String? arrival;
  String? departureTime;
  String? returnDate;
  String? returnTime;
  String? arrivalTime;

  String? hotel;
  late Usersss users = Usersss();
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";
  final String suitcaseIcon = "assets/images/icon/suitcase.png";
  final String planeTicketIcon = "assets/images/icon/plane-ticket.png";
  bool _value = false;
  Booking booking = Booking();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _destinationController.dispose();
    _paymentMethodController.dispose();
    _specialReqController.dispose();
    _age.dispose();
    _country.dispose();
    _lastNameController.dispose();
    _number_of_adult.dispose();
    _number_of_children.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fethHotel(widget.id);
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

  Future<void> fethHotel(
    int id,
  ) async {
    final data = await booking.passTheDate(id);
    final format = NumberFormat('#,###');
    final finalFormat = format.format(data!['price']);
    setState(() {
      amount = data['price'];
      origin = data['airplane'];
      destination = data['place'];
      departure = data['date'];
      arrival = data['date_departure'];
      returnDate = data['return_date'];
      strAmount = finalFormat;
      departureTime = data['departure'];
      arrivalTime = data['arrival'];
      returnTime = data['return'];
    });
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
                            'Travel Confirmation',
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
                              child: Text(
                                'Origin :  $origin',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: 380,
                              child: Text(
                                'Destination :  $destination',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 380,
                            child: Text(
                              'Departure Date:  $departure',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 380,
                            child: Text(
                              'Arrival Date:  $arrival',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 380,
                            child: Text(
                              'Return Date:  $returnDate',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 380,
                            child: Text(
                              'Departure Time :  $departureTime',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            width: 380,
                            child: Text(
                              'Arrival Time :  $arrivalTime',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 380,
                            child: Text(
                              'Return Time :  $returnTime',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                            height: 200,
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
                                              'PHP $strAmount',
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
                                                        nameoftheplace:
                                                            _emailController
                                                                .text
                                                                .trim(),
                                                        price: amount,
                                                        payment: amount,
                                                        hotelorplace:
                                                            _hotel.text,
                                                      );
                                                    } else {
                                                      debugPrint('nigga');
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
