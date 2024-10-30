// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/BookingBackend/hotel_booking.dart';
import 'package:TravelGo/Controllers/NetworkImages/bookingHistory.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/TRGO_POINTS/Trgo.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:TravelGo/Widgets/Textfield/inputTextField.dart';
import 'package:TravelGo/Widgets/Textfield/phoneNumber.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelBookingArea extends StatelessWidget {
  final int id;
  final String? price;
  const HotelBookingArea({
    super.key,
    required this.id,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Go',
      home: HotelBookingAreaScreen(
        id: id,
        price: price,
      ),
    );
  }
}

class HotelBookingAreaScreen extends StatefulWidget {
  final int id;
  final String? price;
  const HotelBookingAreaScreen({
    super.key,
    required this.id,
    this.price,
  });

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
  final _pointsController = TextEditingController();
  final _validator = GlobalKey<FormState>();
  final _hotel = TextEditingController();
  final _number_of_children = TextEditingController();
  final _number_of_adult = TextEditingController();
  final _age = TextEditingController();
  String? email;
  String? place;
  final bool _isWaiting = true;
  final supabase = Supabase.instance.client;
  double amount = 0;
  double amountNumber = 0;
  String? strAmount;
  String? idCast;
  String? hotel;
  late Usersss users = Usersss();
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";
  final String suitcaseIcon = "assets/images/icon/suitcase.png";
  final String planeTicketIcon = "assets/images/icon/plane-ticket.png";
  bool _value = false;
  final tr = Trgo();
  double trgopoint = 0;
  double updatePoint = 0;
  get discountCompute => toDouble(amount)! * 0.2;
  get discountTotal => toDouble(amount)! - discountCompute;
  String? amountDisplay;
  String? discountAmount;
  String? discountSaved;
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
    _age.dispose();
    _hotel.dispose();
    _number_of_adult.dispose();
    _number_of_children.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchInt(widget.id);
    fethHotel(widget.id);
    fetchLocated(widget.id);
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
    final hotel = await booking.bookingIDgenerator();
    idCast = hotel;
    _pointsController.text == "Travel Go Points Used"
        ? amountNumber = discountTotal
        : amountNumber;
    booking.insertBooking(
        _nameController.text.trim(),
        _emailController.text.trim(),
        int.parse(_numberController.text.trim()),
        _hotel.text.trim(),
        _checkInController.text.trim(),
        _checkOutController.text.trim(),
        _paymentMethodController.text.trim(),
        _isWaiting ? "Not Paid" : "Paid",
        int.parse(_number_of_adult.text.trim()),
        int.parse(_number_of_children.text.trim()),
        _vehicleTypeController.text.trim(),
        amountNumber,
        int.parse(_age.text.trim()),
        hotel);
    AppRoutes.navigateToLinkedBankAccount(
      context,
      name: _nameController.text.trim(),
      phone: int.parse(_numberController.text.trim()),
      nameoftheplace: _emailController.text.trim(),
      price: amountNumber,
      payment: amountNumber,
      hotelorplace: _hotel.text,
      age: int.parse(_age.text.trim()),
      bookingId: idCast,
      points: updatePoint,
    );
  }

  Future<void> fetchInt(int id) async {
    final data = await booking.passTheHotelData(id);
    if (data == null) {
      setState(() {
        amount = 0;
      });
    } else {
      double basePrice =
          double.parse(widget.price.toString().replaceAll(',', ''));
      double additionalCost = 0;

      switch (_vehicleTypeController.text.trim()) {
        case 'Deluxe Suite':
          additionalCost = 6000;
          break;
        case 'Premiere Suite':
          additionalCost = 8000;
          break;
        case 'Executive Suite':
          additionalCost = 9000;
          break;
        case 'Presidential Suite':
          additionalCost = 10000;
          break;
        default:
          additionalCost = 0;
      }
      final total = basePrice + additionalCost;
      setState(() {
        amount = total;
        final numberFormat = NumberFormat('#,##0.##');
        final numbers = numberFormat.format(total);
        strAmount = numbers;
      });
    }

    final pts = await tr.getThePointsOfMine();
    setState(() {
      final trgopoint = pts[0]['points'];
      updatePoint = trgopoint - 100.0;
      pts[0]['points'] = updatePoint;
      final numberFormat = NumberFormat('#,##0.##');
      final numbers = numberFormat.format(discountTotal);
      discountAmount = numbers;
      final numbers2 = numberFormat.format(discountCompute);
      discountSaved = numbers2;
      _pointsController.text == "Travel Go Points Used"
          ? (
              amountDisplay = discountAmount, //this is String
              amountNumber = discountTotal // this is number
            )
          : (
              amountDisplay = strAmount, // String
              amountNumber = amount // number
            );
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

  Future<void> fetchLocated(
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
        firstDate: DateTime.now(),
        lastDate: DateTime(21000));
    if (picked != null) {
      setState(() {
        _checkInController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> checkout() async {
    print(_checkInController.text);
    final checkIndate = DateTime.parse(_checkInController.text);
    final picked = await showDatePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialDate: checkIndate,
        firstDate: checkIndate,
        lastDate: DateTime(21000));
    if (picked != null) {
      setState(() {
        _checkOutController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> hotelBookModal(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
              height: 500.h,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 30.h),
                    Text(
                      'Payment Method',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(height: 20.h),
                    ListTile(
                      leading: Icon(Icons.mobile_friendly_rounded, size: 20.sp),
                      title:
                          Text('Pay Online', style: TextStyle(fontSize: 16.sp)),
                      onTap: () {
                        setState(() {
                          _paymentMethodController.text = "Pay Online";
                          Navigator.pop(context);
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.share_arrival_time, size: 20.sp),
                      title: Text('Pay Upon Arrival',
                          style: TextStyle(fontSize: 16.sp)),
                      onTap: () {
                        setState(() {
                          _paymentMethodController.text = "Pay Upon Arrival";
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ));
        });
  }

  Future<void> hotelBookModalRoomType(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
              height: 500.h,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 30.h),
                    Text(
                      'Room Type',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(height: 20.h),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.medal,
                          size: 20.sp, color: Colors.amber),
                      title: Text('Deluxe Suite PHP 6,000',
                          style: TextStyle(fontSize: 16.sp)),
                      onTap: () {
                        setState(() {
                          _vehicleTypeController.text = "Deluxe Suite";
                          fetchInt(widget.id);
                          Navigator.pop(context);
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.crown,
                          size: 20.sp, color: Colors.amber),
                      title: Text('Premiere Suite PHP 8,000',
                          style: TextStyle(fontSize: 16.sp)),
                      onTap: () {
                        setState(() {
                          _vehicleTypeController.text = "Premiere Suite ";
                          fetchInt(widget.id);
                          Navigator.pop(context);
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.gem,
                          size: 20.sp, color: Colors.green),
                      title: Text('Executive Suite PHP 9,000',
                          style: TextStyle(fontSize: 16.sp)),
                      onTap: () {
                        setState(() {
                          _vehicleTypeController.text = "Executive Suite ";
                          fetchInt(widget.id);
                          Navigator.pop(context);
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.diamond,
                          size: 20.sp, color: Colors.blueAccent),
                      title: Text('Presidential Suite PHP 10,000',
                          style: TextStyle(fontSize: 16.sp)),
                      onTap: () {
                        setState(() {
                          _vehicleTypeController.text = "Presidential Suite";
                          fetchInt(widget.id);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ));
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
        body: Form(
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
                              padding: EdgeInsets.only(top: 8.h, right: 10.w),
                              child: IconButton(
                                iconSize: 20.sp,
                                icon: SizedBox(
                                  height: 20.sp,
                                  width: 20.sp,
                                  child: Image.asset(xButtonIcon),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  AppRoutes.navigateToMainMenu(context);
                                }, // change routes to InformationScreen later
                              ),
                            ),
                          ),
                          Text(
                            'Hotel Booking Form',
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Simply enter your travel details, choose your preferred flight, and secure your seat to start your journey.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color.fromARGB(255, 82, 79, 79),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          // ignore: sized_box_for_whitespace
                          Container(
                            width: 350.w,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: inputTextField(
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              icon: const Icon(FontAwesomeIcons.person),
                              colorr: Colors.black,
                              text: 'Full Name:',
                              controller: _nameController,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 350.w,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: inputTextField(
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              icon: const Icon(FontAwesomeIcons.envelope),
                              colorr: Colors.black,
                              text: 'Email Address:',
                              controller: _emailController,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 350.w,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: PhonenumberTextField(
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                              text: 'Phone Number:',
                              controller: _numberController,
                              icon: const Icon(FontAwesomeIcons.phone),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 350.w,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: PhonenumberTextField(
                              text: 'Age:',
                              controller: _age,
                              icon: const Icon(FontAwesomeIcons.personCane),
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Enter your age';
                                } else if (int.parse(value) <= 17) {
                                  return 'You are $value, you must be 18 years or above';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 350.w,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: PhonenumberTextField(
                              icon: const Icon(FontAwesomeIcons.children),
                              controller: _number_of_children,
                              text: 'Number of children:',
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 350.w,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: PhonenumberTextField(
                              icon: const Icon(FontAwesomeIcons.peopleGroup),
                              controller: _number_of_adult,
                              text: 'Number of Adults:',
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                              width: 350.w,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.toString().isEmpty ||
                                      value.length <= 5) {
                                    return 'Please select Check-In Date';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                                controller: _checkInController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText: 'Check In Date',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(fontSize: 12.sp),
                                  prefixIcon:
                                      const Icon(Icons.calendar_today_outlined),
                                ),
                                readOnly: true,
                                onTap: () {
                                  setter();
                                },
                              )),
                          SizedBox(height: 10.h),
                          Container(
                              width: 350.w,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.toString().isEmpty ||
                                      value.length <= 5) {
                                    return 'Please select Check-Out Date';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                                controller: _checkOutController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText: 'Check Out Date',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(fontSize: 12.sp),
                                  prefixIcon:
                                      const Icon(Icons.calendar_today_outlined),
                                ),
                                readOnly: true,
                                onTap: () {
                                  checkout();
                                },
                              )),
                          SizedBox(height: 10.h),
                          Container(
                              width: 350.w,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Payment method is required';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                                controller: _paymentMethodController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText: 'Payment Method [Click to Select]',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(fontSize: 12.sp),
                                  prefixIcon: const Icon(Icons.payment_rounded),
                                ),
                                readOnly: true,
                                onTap: () {
                                  hotelBookModal(context);
                                },
                              )),
                          SizedBox(height: 10.h),
                          Container(
                              width: 350.w,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.toString().isEmpty) {
                                    return 'Please select a Room Type';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                                controller: _vehicleTypeController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText: 'Room Type [Click to Select]',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(fontSize: 12.sp),
                                  prefixIcon: const Icon(Icons.room_outlined),
                                ),
                                readOnly: true,
                                onTap: () {
                                  hotelBookModalRoomType(context);
                                },
                              )),
                          SizedBox(height: 10.h),
                          Container(
                            width: 350.w,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: inputTextField(
                              colorr: Colors.black,
                              text: 'Special Requests: (Optional)',
                              controller: _originController,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                              width: 350.w,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                                controller: _pointsController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  hintText:
                                      'Use my Travel Go Points (Available $trgopoint)',
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(fontSize: 12.sp),
                                  prefixIcon:
                                      const Icon(FontAwesomeIcons.coins),
                                ),
                                readOnly: true,
                                onTap: () {
                                  showAdaptiveDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            title: Text(
                                                'Available Travel Go Points:\n$trgopoint',
                                                style:
                                                    TextStyle(fontSize: 20.sp)),
                                            content: SingleChildScrollView(
                                                child:
                                                    ListBody(children: <Widget>[
                                              if (trgopoint < 100) ...[
                                                Text('Insufficient Points!',
                                                    style: TextStyle(
                                                        fontSize: 16.sp))
                                              ] else ...[
                                                Text(
                                                    'Total Price: \nPHP $strAmount\n',
                                                    style: TextStyle(
                                                        fontSize: 16.sp)),
                                                Text(
                                                    'Saved: \nPHP $discountSaved\n',
                                                    style: TextStyle(
                                                        fontSize: 16.sp)),
                                                Text(
                                                    'Discounted Price: \nPHP $discountAmount',
                                                    style: TextStyle(
                                                        fontSize: 16.sp))
                                              ]
                                            ])),
                                            actions: <Widget>[
                                              if (trgopoint < 100) ...[
                                                TextButton(
                                                  child: Text('Back',
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ] else ...[
                                                TextButton(
                                                  child: Text('Use',
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  onPressed: () {
                                                    setState(() {
                                                      fetchInt(widget.id);
                                                      _pointsController.text =
                                                          "Travel Go Points Used";
                                                    });
                                                    Navigator.pop(context);
                                                    // FUNCTION
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Cancel',
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ]
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              )),
                          Theme(
                            data: ThemeData(
                              checkboxTheme: const CheckboxThemeData(
                                  shape: CircleBorder()),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: ListTileTheme(
                                contentPadding:
                                    EdgeInsets.only(left: 20.w, right: 10.w),
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
                                              fontSize: 13.sp,
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
                            height: 90.sp,
                            width: double.infinity, // Adjust width as needed
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 25.sp),
                              child: Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 50.sp,
                                        child: Image.asset(adventureIcon),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20.sp,
                                        child: Image.asset(suitcaseIcon),
                                      ),
                                      SizedBox(
                                        height: 30.sp,
                                        child: Image.asset(planeTicketIcon),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            fetchInt(widget.id);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total Amount",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: const Color.fromARGB(
                                                        255, 26, 169, 235),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(children: [
                                          Text(
                                            'PHP $amountDisplay',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ])
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 40.sp,
                                        width: 130.sp,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue),
                                            onPressed: _value
                                                ? () {
                                                    if (_validator.currentState!
                                                        .validate()) {
                                                      if (_paymentMethodController
                                                              .text
                                                              .trim() ==
                                                          "Pay Online") {
                                                        BookinghistoryBackend()
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
                                                          _checkInController
                                                              .text
                                                              .trim(),
                                                          _checkOutController
                                                              .text
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
                                                          _vehicleTypeController
                                                              .text
                                                              .trim(),
                                                          int.parse(
                                                              _age.text.trim()),
                                                          amount,
                                                        );
                                                        insert();
                                                        tr.getThePointsOfMine();
                                                      } else if (_paymentMethodController
                                                              .text
                                                              .trim() ==
                                                          "Pay Upon Arrival") {
                                                        print(
                                                            'Pay Upon Arrival is empty');
                                                      }
                                                    } else {
                                                      print('nigga');
                                                    }
                                                  }
                                                : null,
                                            child: Text(
                                              'Place Booking',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp),
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10.h),
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
