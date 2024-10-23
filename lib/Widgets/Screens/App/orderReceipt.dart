import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/BookingBackend/hotel_booking.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/mail/Mailer.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/TextWidgets/rowDetails.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main(phone) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(OrderReceipt(bookingId: phone));
}

class OrderReceipt extends StatelessWidget {
  final String? bookingId;
  const OrderReceipt({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Receipt'
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: OrderReceiptScreen(bookingId: bookingId),
    );
  }
}

class OrderReceiptScreen extends StatefulWidget {
  final String? bookingId;
  const OrderReceiptScreen({
    super.key,
    this.bookingId,
  });

  @override
  State<OrderReceiptScreen> createState() => _OrderReceiptScreenState();
}

class _OrderReceiptScreenState extends State<OrderReceiptScreen> {
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String receiptBackground = "assets/images/backgrounds/Receipt.png";
  var email;
  String? paid_via;
  String amount = "loading";
  var phone;
  String? gmail;
  String ref = "loading";
  var date;
  String account = "loading";
  late Usersss users = Usersss();
  late HotelBooking book = HotelBooking();

  @override
  void initState() {
    super.initState();
    emailFetching();
    finalReceipt('${widget.bookingId}');
  }

  void main() async {
    Mailer mailer = Mailer();

    String pdfPath = await mailer.generatePdfReceipt(
      amount: amount,
      phone: phone,
      ref: ref,
      date: DateTime.now(),
      account: account,
      gmail: '$gmail',
    );

    await mailer.sendEmailWithAttachment(
      context,
      subject: 'Your Booking Receipt',
      body: 'Please find your receipt attached.',
      recipientEmail: '$gmail',
      filePath: pdfPath,
    );
  }

  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users.fetchUser();
      if (useremail.isNotEmpty) {
        if (mounted) {
          setState(() {
            email = useremail[0]['full_name'].toString();
          });
        }
      } else if (mounted) {
        setState(() {
          email = "Anonymous User";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          email = "error: $e";
        });
      }
    }
  }

  Future<void> finalReceipt(String uid) async {
    try {
      final response = await book.paymentReceipt(uid);
      if (response != null) {
        if (mounted) {
          final data = response;
          setState(() {
            amount =
                data['payment'] != null ? data['payment'].toString() : 'N/A';
            phone = data['phone'] ?? 'Unknown';
            ref = data['reference_number'] ?? 'N/A';
            paid_via = data['pay_via'] ?? 'Unknown';
            date = data['date_of_payment'] ?? 'Unknown Date';
            account = data['name'] ?? 'Unknown Account';
            gmail = data['gmail'] ?? 'Unknown';
          });
        }
      } else {
        print('No data received from paymentReceipt');
      }
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                const SizedBox(height: 40),
                                const Text(
                                  'Thank You for Your Booking!',
                                  style: TextStyle(
                                    color: Color.fromRGBO(8, 44, 72, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(xButtonIcon),
                                ),
                                const SizedBox(height: 40),
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  height: 150,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black)),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
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
                                              row2: (account).toUpperCase(),
                                            ),
                                            RowDetails(
                                              row1: 'CONTACT NUMBER',
                                              row2: '$phone',
                                            ),
                                            RowDetails(
                                              row1: 'EMAIL',
                                              row2: '$gmail',
                                            ),
                                            RowDetails(
                                              row1: 'AMOUNT',
                                              row2: amount,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 100,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'TOTAL AMOUNT: $amount',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              Text(
                                                'Paid using $paid_via',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 6,
                                                  color: Color.fromRGBO(
                                                      5, 103, 180, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'PHP $amount',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Color.fromRGBO(
                                                  5, 103, 180, 1),
                                            ),
                                          )
                                        ],
                                      ),
                                      RowDetails(
                                          row1: 'Date paid', row2: '$date'),
                                      RowDetails(
                                          row1: 'Reference no.', row2: ref),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                BlueButtonWithoutFunction(
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
                                  oppressed: () async {
                                    main();
                                  },
                                ),
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

  @override
  void dispose() {
    super.dispose();
  }
}
