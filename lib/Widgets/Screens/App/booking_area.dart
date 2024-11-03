// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/BookingBackend/booking.dart';
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
      home: BookingAreaScreen(
        id: id,
      ),
    );
  }
}

class BookingAreaScreen extends StatefulWidget {
  final int id;
  const BookingAreaScreen({
    super.key,
    required this.id,
  });

  @override
  State<BookingAreaScreen> createState() => _BookingAreaScreenState();
}

class _BookingAreaScreenState extends State<BookingAreaScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _destinationController = TextEditingController();
  final _originController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _specialReqController = TextEditingController();
  final _pointsController = TextEditingController();
  final _validator = GlobalKey<FormState>();
  final _country = TextEditingController();
  final _phone = TextEditingController();
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

  String? hotel;
  late Usersss users = Usersss();
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";
  final String suitcaseIcon = "assets/images/icon/suitcase.png";
  final String planeTicketIcon = "assets/images/icon/plane-ticket.png";
  bool _value = false;
  final trgo = Trgo();
  num trgopoint = 0.0;
  double discountSaved = 1000;
  double discountTotal = 0;
  String? amountDisplay;
  String? discountAmount;
  Booking booking = Booking();
  bool _isRedirecting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _phone.dispose();
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
    getPoints();
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

  Future<void> getPoints() async {
    final response = await trgo.getThePointsOfMine();
    if (response == null) {
      setState(() {
        amount = 0;
      });
    } else {
      setState(() {
        trgopoint = response['withdrawablePoints'];
        discountTotal = amount - discountSaved;
        final numberFormat = NumberFormat('#,##0.##');
        final numbers = numberFormat.format(discountTotal);
        discountAmount = numbers;
        _pointsController.text == "Travel Go Points Used"
            ? (
                amountDisplay = discountAmount, //this is String
                amountNumber = discountTotal // this is number
              )
            : (
                amountDisplay = strAmount, // String
                amountNumber = amount // number
              );
        _isRedirecting = false;
      });
    }
  }

  Future<void> fetchFlight(int id) async {
    final data = await booking.passTheDate(id);
    final format = NumberFormat('#,##0.##');
    final finalFormat = format.format(toDouble(data!['price']));
    setState(() {
      amount = toDouble(data['price'])!;
      origin = data['airplane'];
      destination = data['place'];
      strAmount = finalFormat;
      _isRedirecting = false;
    });
  }

  Future<void> flightsPaymentModal(BuildContext context) async {
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
                                  'User Credentials',
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Simply enter your travel details, choose your preferred flight, and secure your seat to start your journey.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color:
                                        const Color.fromARGB(255, 82, 79, 79),
                                  ),
                                ),
                                SizedBox(height: 30.h),
                                // ignore: sized_box_for_whitespace
                                Container(
                                  width: 350.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: inputTextField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.toString().isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    icon: const Icon(FontAwesomeIcons.person),
                                    colorr: Colors.black,
                                    text: 'First Name:',
                                    controller: _nameController,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 350.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: inputTextField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.toString().isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    icon: const Icon(FontAwesomeIcons.person),
                                    colorr: Colors.black,
                                    text: 'Last Name:',
                                    controller: _lastNameController,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 350.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: inputTextField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.toString().isEmpty) {
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: PhonenumberTextField(
                                    text: 'Phone Number:',
                                    validator: (value) {
                                      if (value == null ||
                                          value.toString().isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      return null;
                                    },
                                    controller: _phone,
                                    icon: const Icon(FontAwesomeIcons.phone),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 350.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: PhonenumberTextField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.toString().isEmpty) {
                                        return 'Enter your age';
                                      } else if (int.parse(value) <= 17) {
                                        return 'You are $value, you must be 18 years or above';
                                      }
                                      return null;
                                    },
                                    text: 'Age:',
                                    controller: _age,
                                    icon:
                                        const Icon(FontAwesomeIcons.personCane),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 350.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: inputTextField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.toString().isEmpty) {
                                        return 'Please enter your Country';
                                      }
                                      return null;
                                    },
                                    icon: const Icon(
                                        FontAwesomeIcons.earthAfrica),
                                    colorr: Colors.black,
                                    text: 'Country:',
                                    controller: _country,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: 350.w,
                                  child: PhonenumberTextField(
                                    icon: const Icon(FontAwesomeIcons.children),
                                    controller: _number_of_children,
                                    text: 'Number of children:',
                                    validator: (value) {
                                      if (value == null ||
                                          value.toString().isEmpty) {
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: PhonenumberTextField(
                                    icon: const Icon(
                                        FontAwesomeIcons.peopleGroup),
                                    controller: _number_of_adult,
                                    text: 'Number of Adults:',
                                    validator: (value) {
                                      if (value == null ||
                                          value.toString().isEmpty) {
                                        return 'Please enter a number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                    width: 350.w,
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.black),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Payment method is required';
                                        }
                                        return null;
                                      },
                                      controller: _paymentMethodController,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue)),
                                        hintText: 'Payment Method',
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(fontSize: 12.sp),
                                        prefixIcon:
                                            const Icon(Icons.payment_rounded),
                                      ),
                                      readOnly: true,
                                      onTap: () {
                                        flightsPaymentModal(context);
                                      },
                                    )),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 350.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
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
                                        fetchFlight(widget.id);
                                        getPoints();
                                        showAdaptiveDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Available Travel Go Points:\n$trgopoint',
                                                      style: TextStyle(
                                                          fontSize: 20.sp)),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: ListBody(
                                                              children: <Widget>[
                                                        if (trgopoint < 1) ...[
                                                          Text(
                                                              'Insufficient Points!',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp))
                                                        ] else ...[
                                                          Text(
                                                              'Total Price: \nPHP $strAmount\n',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp)),
                                                          Text(
                                                              'Discounted Price: \nPHP $discountAmount',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp))
                                                        ]
                                                      ])),
                                                  actions: <Widget>[
                                                    if (trgopoint < 1) ...[
                                                      TextButton(
                                                        child: Text('Back',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    16.sp)),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ] else ...[
                                                      TextButton(
                                                        child: Text('Use',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    16.sp)),
                                                        onPressed: () {
                                                          setState(() {
                                                            fetchFlight(
                                                                widget.id);
                                                            getPoints();
                                                            _pointsController
                                                                    .text =
                                                                "Travel Go Points Used";
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                          // FUNCTION
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Cancel',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    16.sp)),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
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
                                              text:
                                                  TextSpan(children: <TextSpan>[
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
                                        )),
                                  ),
                                ),
                                Container(
                                  width:
                                      double.infinity, // Adjust width as needed
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
                                              child:
                                                  Image.asset(planeTicketIcon),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
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
                                                    'PHP $amountDisplay',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                              .validate()) {
                                                            if (_paymentMethodController
                                                                    .text
                                                                    .trim() ==
                                                                "Pay Online") {
                                                              if (_pointsController
                                                                      .text ==
                                                                  "Travel Go Points Used") {
                                                                trgo.spendPoints(
                                                                    context);
                                                                amountNumber =
                                                                    discountTotal;
                                                              }
                                                              AppRoutes.navigateToNextScreen(
                                                                  context,
                                                                  id: widget.id,
                                                                  name: _nameController
                                                                      .text
                                                                      .trim(),
                                                                  email: _emailController
                                                                      .text
                                                                      .trim(),
                                                                  phone: int.parse(
                                                                      _phone
                                                                          .text
                                                                          .trim()),
                                                                  age: int.parse(
                                                                      _age.text
                                                                          .trim()),
                                                                  country:
                                                                      _country
                                                                          .text
                                                                          .trim(),
                                                                  numberOfChildren:
                                                                      int.parse(
                                                                          _number_of_children.text.trim()),
                                                                  numberOfAdults: int.parse(_number_of_adult.text.trim()),
                                                                  paymentMethod: _paymentMethodController.text.trim(),
                                                                  price: amountNumber,
                                                                  last: _lastNameController.text.trim());
                                                            } else if (_paymentMethodController
                                                                    .text
                                                                    .trim() ==
                                                                "Pay Upon Arrival") {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                content: Text(
                                                                    'Pay Upon Arrival is currently unavailable.'),
                                                              ));
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Please fill up the required fields.'),
                                                            ));
                                                          }
                                                        }
                                                      : null,
                                                  child: Text(
                                                    'Next',
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
