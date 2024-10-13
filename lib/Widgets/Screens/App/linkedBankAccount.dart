// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:TravelGo/Widgets/Screens/App/orderReceipt.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/paymentIntegration/paypal.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/AccountButton.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';

class LinkedBankScreen extends StatefulWidget {
  final String name;
  final int phone;
  final String hotelorplace;
  final String nameoftheplace;
  final int price;
  final int payment;

  const LinkedBankScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.hotelorplace,
    required this.nameoftheplace,
    required this.price,
    required this.payment, String? origin, String? destination,
  });

  @override
  State<LinkedBankScreen> createState() => _LinkedBankScreenState();
}

class _LinkedBankScreenState extends State<LinkedBankScreen> {
  final String paypalIcon = "assets/images/icon/paypal.png";
  final String gcashIcon = "assets/images/icon/gcash.png";
  final String mastercardIcon = "assets/images/icon/mastercard.png";
  final _searchController = TextEditingController();
  String? email;
  late Usersss users = Usersss();
  List<Map<String, dynamic>> place = [];
  final data = Data();
  late bool isPaymentSuccess = false;

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
    await Paypal().pay(
      context,
      widget.price,
      widget.hotelorplace,
      widget.price,
      widget.name,
      widget.phone,
      widget.nameoftheplace,
    );
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
                const SizedBox(
                  height: 30,
                ),
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
                  style: TextStyle(fontSize: 16), // Adjust text style as needed
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Linked Bank Accounts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 420,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AccountButton(
                        header: "Master Cards",
                        details: "0193129031903",
                        color: const Color.fromRGBO(39, 92, 135, 1),
                        image: mastercardIcon,
                        oppressed: () =>
                            AppRoutes.navigateToCreditCard(context),
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
                      AccountButton(
                        header: "Gcash",
                        details: "0193129031903",
                        color: const Color.fromRGBO(57, 167, 255, 1),
                        image: gcashIcon,
                        oppressed: () => print('uwu'),
                      ),
                    ],
                  ),
                ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderReceipt(Phone: widget.phone)));
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
