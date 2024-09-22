// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:itransit/Controllers/BookingBackend/hotel_booking.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/Widgets/Drawer/drawerMenu.dart';
import 'package:itransit/Widgets/TextWidgets/rowDetails.dart';

class OrderReceipt extends StatelessWidget {
  final int Phone;
  const OrderReceipt({
    super.key,
    required this.Phone,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel',
        home: OrderReceiptScreen(Phone: Phone));
  }
}

class OrderReceiptScreen extends StatefulWidget {
  final int Phone;
  const OrderReceiptScreen({
    super.key,
    required this.Phone,
  });

  @override
  State<OrderReceiptScreen> createState() => _OrderReceiptScreenState();
}

class _OrderReceiptScreenState extends State<OrderReceiptScreen> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String receiptBackground = "assets/images/backgrounds/Receipt.png";
  final _searchController = TextEditingController();
  String? email;
  String? amount;
  var phone;
  String? ref;
  var date;
  String? account;
  late Usersss users = Usersss();
  late HotelBooking book = HotelBooking();

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

  Future<void> finalReceipt(BuildContext context, int uid) async {
    try {
      final response = await book.paymentReceipt(context, uid);
      if (response == null) {
        print('haha');
      } else {
        final data = response;
        setState(() {
          amount = data['amount'];
          phone = data['phone'];
          ref = data['ref'];
          date = data['date_of_payment'];
          account = data['name'];
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    finalReceipt(context, widget.Phone);
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
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 600,
                            width: 320,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.asset(receiptBackground).image,
                                  fit: BoxFit.fill),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Booking Confirmed!',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(0, 107, 146, 1),
                                          ),
                                        ),
                                        Text(
                                          '$date',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      alignment: Alignment.topRight,
                                      iconSize: 20,
                                      icon: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(xButtonIcon),
                                      ),
                                      onPressed: () =>
                                          print(''), // Add route later
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  'Thank You for Your Booking!',
                                  style: TextStyle(
                                    color: Color.fromRGBO(8, 44, 72, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(xButtonIcon),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  height: 150,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black,
                                      )),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'BILLER',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              'Travel Go',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Color.fromRGBO(
                                                    5, 103, 180, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 10,
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            RowDetails(
                                              row1: 'ACCOUNT',
                                              row2: (email != null
                                                      ? '$email'
                                                      : 'Hacked himala e')
                                                  .toUpperCase(),
                                            ),
                                            RowDetails(
                                              row1: 'CONTACT NUMBER',
                                              row2: 'PLACEHOLDER',
                                            ),
                                            RowDetails(
                                              row1: 'EMAIL',
                                              row2: 'PLACEHOLDER',
                                            ),
                                            RowDetails(
                                              row1: 'AMOUNT',
                                              row2: 'PLACEHOLDER',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 100,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black,
                                      )),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'TOTAL AMOUNT',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              // Placeholder but change this later
                                              Text(
                                                'Paid using paypal',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 6,
                                                  color: Color.fromRGBO(
                                                      5, 103, 180, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'PHP 6,000',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Color.fromRGBO(
                                                  5, 103, 180, 1),
                                            ),
                                          )
                                        ],
                                      ),
                                      RowDetails(
                                          row1: 'Date paid', row2: 'Date'),
                                      RowDetails(
                                          row1: 'Reference no.',
                                          row2: 'NUMBERNUMBER'),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromARGB(94, 0, 0, 0),
                                            spreadRadius: -8,
                                            blurRadius: 10,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: BlueButtonWithoutFunction(
                                    text: const Text(
                                      'Email My Receipt',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.white),
                                    ),
                                    oppressed: () => print(''),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
