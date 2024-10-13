// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/BookingBackend/booking.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:TravelGo/Widgets/Textfield/inputTextField.dart';
import 'package:TravelGo/Widgets/Textfield/phoneNumber.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  var amount = 0;
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
  Booking booking = Booking();

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
      strAmount = finalFormat;
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
              const TitleMenu(),
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
                            'User Credentials',
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
                              text: 'First Name:',
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
                              text: 'Last Name:',
                              controller: _lastNameController,
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
                              controller: _phone,
                              icon: const Icon(FontAwesomeIcons.phone),
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter an active number';
                                }
                                return null;
                              },
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
                              text: 'Age:',
                              controller: _age,
                              icon: const Icon(FontAwesomeIcons.personCane),
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter your age';
                                } else if (value <= 18) {
                                  return 'You are below 18';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                  return 'please enter your Country';
                                }
                                return null;
                              },
                              icon: const Icon(FontAwesomeIcons.earthAfrica),
                              colorr: Colors.black,
                              text: 'Country:',
                              controller: _country,
                            ),
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
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
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
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return 'Please enter a number';
                                }
                                return null;
                              },
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
                                                      AppRoutes.navigateToNextScreen(
                                                          context,
                                                          id: widget.id,
                                                          name: _nameController
                                                              .text
                                                              .trim(),
                                                          email:
                                                              _emailController
                                                                  .text
                                                                  .trim(),
                                                          phone: int.parse(
                                                              _phone.text
                                                                  .trim()),
                                                          age: int.parse(
                                                              _age.text.trim()),
                                                          country: _country.text
                                                              .trim(),
                                                          numberOfChildren:
                                                              int.parse(
                                                                  _number_of_children
                                                                      .text
                                                                      .trim()),
                                                          numberOfAdults:
                                                              int.parse(_number_of_adult.text.trim()),
                                                          paymentMethod: _paymentMethodController.text.trim(),
                                                          price: amount,
                                                          last: _lastNameController.text.trim());
                                                    } else {
                                                      debugPrint('nigga');
                                                    }
                                                  }
                                                : null,
                                            child: const Text(
                                              'Next',
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
