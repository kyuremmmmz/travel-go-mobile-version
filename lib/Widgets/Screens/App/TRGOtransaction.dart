import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/BookingBackend/hotel_booking.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/mail/Mailer.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/TextWidgets/rowDetails.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main(phone) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Trgotransaction(bookingId: phone));
}

class Trgotransaction extends StatelessWidget {
  final String? bookingId;
  final String? transactionId;
  const Trgotransaction({
    super.key,
    required this.bookingId, 
    this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.h,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text('Order Receipt'),
      ),
      drawer: const DrawerMenuWidget(),
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
  final String logoIcon = "assets/images/icon/newlogo-crop.png";
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
  String dateFormatted = "";
  bool _isRedirecting = false;

  @override
  void initState() {
    super.initState();
    emailFetching();
    finalReceipt('${widget.bookingId}');
    _isRedirecting = true;
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
            dateFormatted = DateFormat("MMM dd, yyyy - h:mm a").format(date);
            _isRedirecting = false;
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
      body: _isRedirecting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: <Widget>[
                      const TitleMenu(),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image.asset(receiptBackground)
                                            .image,
                                        fit: BoxFit.fill),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Booking Confirmed!',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromRGBO(
                                                      0, 107, 146, 1),
                                                ),
                                              ),
                                              Text(
                                                '$dateFormatted',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                              alignment: Alignment.topRight,
                                              iconSize: 20.sp,
                                              icon: SizedBox(
                                                height: 20.sp,
                                                width: 20.sp,
                                                child: Image.asset(xButtonIcon),
                                              ),
                                              onPressed: () => {
                                                    Navigator.pop(context),
                                                    AppRoutes
                                                        .navigateToMainMenu(
                                                            context)
                                                  }),
                                        ],
                                      ),
                                      SizedBox(height: 30.h),
                                      Text(
                                        'Thank You for Booking!',
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              8, 44, 72, 1),
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150.sp,
                                        child: Image.asset(logoIcon),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        width: 260.sp,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.sp),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'BILLER',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Travel Go',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.sp,
                                                      color:
                                                          const Color.fromRGBO(
                                                              5, 103, 180, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              height: 1.h,
                                              color: Colors.black,
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.sp),
                                              child: Column(
                                                children: [
                                                  RowDetails(
                                                    row1: 'ACCOUNT',
                                                    row2:
                                                        (account).toUpperCase(),
                                                  ),
                                                  RowDetails(
                                                    row1: 'CONTACT NUMBER',
                                                    row2: '+63 0$phone',
                                                  ),
                                                  RowDetails(
                                                    row1: 'EMAIL',
                                                    row2: '$gmail',
                                                  ),
                                                  RowDetails(
                                                    row1: 'AMOUNT',
                                                    row2: amount,
                                                  ),
                                                  SizedBox(height: 5.h)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        padding: EdgeInsets.all(10.sp),
                                        width: 260.sp,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'TOTAL AMOUNT:',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Paid using $paid_via',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 6.sp,
                                                        color: const Color
                                                            .fromRGBO(
                                                            5, 103, 180, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'PHP $amount',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp,
                                                    color: const Color.fromRGBO(
                                                        5, 103, 180, 1),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5.h),
                                            RowDetails(
                                                row1: 'Date paid',
                                                row2: '$dateFormatted'),
                                            SizedBox(height: 5.h),
                                            RowDetails(
                                                row1: 'Reference no.',
                                                row2: ref),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      BlueButtonWithoutFunction(
                                        text: Text(
                                          'Email My Receipt',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.white),
                                        ),
                                        oppressed: () async {
                                          main();
                                        },
                                      ),
                                      SizedBox(height: 20.h)
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
