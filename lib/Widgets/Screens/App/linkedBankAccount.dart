// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/TRGO_POINTS/Trgo.dart';
import 'package:TravelGo/Controllers/paymentIntegration/paypal.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/AccountButton.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/crypto/wallet.dart';
import 'package:TravelGo/Widgets/Screens/App/orderReceipt.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LinkedBankScreen extends StatefulWidget {
  final String name;
  final int phone;
  final String? bookingId;
  final String hotelorplace;
  final String nameoftheplace;
  final double price;
  final double payment;
  final int age;

  const LinkedBankScreen({
    super.key,
    String? origin,
    String? destination,
    required this.name,
    required this.phone,
    required this.hotelorplace,
    required this.nameoftheplace,
    required this.price,
    required this.payment,
    required this.age,
    this.bookingId,
    required points,
  });

  @override
  State<LinkedBankScreen> createState() => _LinkedBankScreenState();
}

class _LinkedBankScreenState extends State<LinkedBankScreen> {
  final String paypalIcon = "assets/images/icon/paypal.png";
  final String gcashIcon = "assets/images/icon/gcash.png";
  final String mastercardIcon = "assets/images/icon/mastercard.png";
  final String trgo = "assets/images/icon/newlogo-crop.png";
  final _searchController = TextEditingController();
  String? email;
  late Usersss users = Usersss();
  List<Map<String, dynamic>> place = [];
  final data = Data();
  late bool isPaymentSuccess = false;
  num money = 0;
  final trGoMoney = Trgo();
  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users.fetchUser();
      if (mounted) {
        setState(() {
          email = useremail.isNotEmpty
              ? useremail[0]['full_name'].toString()
              : "Anonymous User";
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

  Future<void> paymentHandler() async {
    await Paypal().pay(context, widget.price, widget.hotelorplace, widget.price,
        widget.name, widget.phone, widget.nameoftheplace, widget.bookingId);
    if (mounted) {
      setState(() {
        isPaymentSuccess = true;
      });
    }
  }

  Future<void> fetchImage() async {
    final datas = await data.fetchImageandText();
    if (mounted) {
      setState(() {
        place = datas;
      });
    }
  }

  Future<void> fethMoney() async {
    final response = await trGoMoney.fetchMoney();
    if (mounted) {
      setState(() {
        money = response!['money'];
        print(money);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchImage();
    fethMoney();
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
                const TitleMenu(),
                Text(
                  'Linked Bank Accounts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(height: 30.sp),
                SizedBox(
                    height: 420.h,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AccountButton(
                            header: "Master Cards",
                            details: "0193129031903",
                            color: const Color.fromRGBO(39, 92, 135, 1),
                            image: mastercardIcon,
                            oppressed: () => AppRoutes.navigateToCreditCard(
                              context,
                              hotelorplace: widget.hotelorplace,
                              name: widget.name,
                              phone: widget.phone,
                              nameoftheplace: widget.nameoftheplace,
                              price: widget.price,
                              payment: widget.price,
                              age: widget.age,
                              bookingId: '${widget.bookingId}',
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AccountButton(
                            header: "PayPal",
                            details: "0193129031903",
                            color: const Color.fromRGBO(5, 103, 180, 1),
                            image: paypalIcon,
                            oppressed: () {
                              paymentHandler();
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AccountButton(
                            header: "Gcash",
                            details: "0193129031903",
                            color: const Color.fromRGBO(57, 167, 255, 1),
                            image: gcashIcon,
                            oppressed: () => print('uwu'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AccountButton(
                            header: "TRGO COINS",
                            details: "Use TRGO coins to pay my travel cost",
                            color: const Color.fromARGB(255, 99, 208, 223),
                            image: trgo,
                            oppressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WalletPaymentScreen(
                                      hotelorplace: widget.hotelorplace,
                                          name: widget.name,
                                          phone: widget.phone,
                                          nameoftheplace: widget.nameoftheplace,
                                          price: widget.price,
                                          payment: widget.price,
                                          booking_id: '${widget.bookingId}',
                                        )
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            )),
                const SizedBox(
                  height: 30,
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
                        'Claim my Receipt',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromRGBO(68, 202, 249, 1)),
                      ),
                      oppressed: () {
                        if (isPaymentSuccess) {
                          Trgo().trgoPoints(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderReceipt(
                                      bookingId: widget.bookingId)));
                        } else {
                          AppRoutes.navigateToNotPaid(context);
                        }
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
