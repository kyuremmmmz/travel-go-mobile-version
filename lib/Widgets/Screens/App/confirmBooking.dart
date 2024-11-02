// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/BookingBackend/booking.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:TravelGo/Widgets/Textfield/inputTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final double price;
  final String last;
  final String bookingId;

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
    required this.bookingId,
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
          bookingId: bookingId,
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
  final double price;
  final String bookingId;
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
    required this.bookingId,
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
  final _age = TextEditingController();
  final _lastNameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final _number_of_children = TextEditingController();
  // ignore: non_constant_identifier_names
  final _number_of_adult = TextEditingController();
  String? email;
  String? place;
  final supabase = Supabase.instance.client;
  double amount = 0;
  double amountNumber = 0;
  String? strAmount;
  String? origin;
  String? destination;
  String? departure;
  String? arrival;
  String? departureTime;
  String? returnDate;
  String? returnTime;
  String? arrivalTime;
  String? airPort;
  String? airLine;
  String? hotel;
  String? confirm;
  late Usersss users = Usersss();
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";
  final String suitcaseIcon = "assets/images/icon/suitcase.png";
  final String planeTicketIcon = "assets/images/icon/plane-ticket.png";
  bool _value = false;
  Booking booking = Booking();
  double updatePoint = 0;
  bool _isRedirecting = false;

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
    fetchFlight(widget.id);
    _isRedirecting = true;
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

  Future<void> insert() async {
    final confirmId = await booking.bookingIDgenerator();
    confirm = confirmId;
    AppRoutes.navigateToLinkedBankAccount(context,
        name: widget.name,
        phone: widget.phone,
        nameoftheplace: widget.email,
        price: amountNumber,
        payment: amountNumber,
        hotelorplace: widget.country,
        age: widget.age,
        bookingId: confirm,
        points: updatePoint);
    Booking().flightBooking(
        widget.name,
        widget.last,
        widget.country,
        widget.phone,
        widget.age,
        widget.email,
        '$origin',
        '$returnDate',
        '$departure',
        '$departureTime',
        '$arrivalTime',
        '$arrival',
        '$destination',
        amount,
        widget.paymentMethod,
        'Cebu Pacific',
        widget.country,
        'Road Trip',
        confirmId);
  }

  Future<void> fetchFlight(int id) async {
    final data = await booking.passTheDate(id);
    final format = NumberFormat('#,###.##');
    final finalFormat = format.format(widget.price);
    setState(() {
      amountNumber = widget.price;
      origin = data!['airplane'];
      destination = data['place'];
      departure = data['date'];
      arrival = data['date_departure'];
      returnDate = data['return_date'];
      strAmount = finalFormat;
      departureTime = data['departure'];
      arrivalTime = data['arrival'];
      returnTime = data['return'];
      airPort = data['airPort'];
      _isRedirecting = false;
    });
  }

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
        ),
        drawer: const DrawerMenuWidget(),
        body: _isRedirecting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _validator,
                child: Column(
                  children: <Widget>[
                    const TitleMenu(),
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
                                    padding:
                                        EdgeInsets.only(top: 8.h, right: 10.w),
                                    child: IconButton(
                                      iconSize: 20.sp,
                                      icon: SizedBox(
                                          height: 20.sp,
                                          width: 20.sp,
                                          child: Image.asset(xButtonIcon)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        AppRoutes.navigateToMainMenu(context);
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  'Travel Confirmation',
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text(
                                      "Review your travel details, your preferred flight, and secure your seat to start your journey.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color.fromARGB(
                                            255, 82, 79, 79),
                                      ),
                                    )),
                                SizedBox(height: 10.h),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Text(
                                      'Origin :  $origin',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(height: 10.h),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Text(
                                      'Destination :  $destination',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(height: 10.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    'Departure Date:  $departure',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    'Arrival Date:  $arrival',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    'Return Date:  $returnDate',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    'Departure Time :  $departureTime',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    'Arrival Time :  $arrivalTime',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text(
                                    'Return Time :  $returnTime',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 350.w,
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
                                    controller: _originController,
                                  ),
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
                                      contentPadding: EdgeInsets.only(
                                          left: 20.w, right: 10.w),
                                      horizontalTitleGap: 0,
                                      child: Transform.scale(
                                        scale: 1.1,
                                        child: CheckboxListTile(
                                          activeColor: Colors.green,
                                          title: RichText(
                                            text: TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "I have reviewed my booking details and agree to the ",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: "Terms of Service.",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.white),
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
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(width: 10.w),
                                        Column(
                                          children: [
                                            SizedBox(
                                                height: 50.sp,
                                                child:
                                                    Image.asset(adventureIcon)),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                                height: 20.sp,
                                                child:
                                                    Image.asset(suitcaseIcon)),
                                            SizedBox(
                                                height: 30.sp,
                                                child: Image.asset(
                                                    planeTicketIcon)),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Total Amount",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 26, 169, 235),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'PHP $strAmount',
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 50.sp,
                                              width: 130.sp,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blue),
                                                  onPressed: _value
                                                      ? () {
                                                          if (_validator
                                                                  .currentState!
                                                                  .validate() ||
                                                              widget.paymentMethod ==
                                                                  "Pay Online") {
                                                            insert();
                                                          } else {
                                                            debugPrint('nigga');
                                                          }
                                                        }
                                                      : null,
                                                  child: Text(
                                                    'Place Booking',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.sp),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.w)
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
