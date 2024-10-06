// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Screens/App/orderReceipt.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:itransit/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:itransit/Controllers/Profiles/ProfileController.dart';
import 'package:itransit/Controllers/paymentIntegration/paypal.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/AccountButton.dart';
import 'package:itransit/Widgets/Drawer/drawerMenu.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({
    super.key,
  });

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
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
                SizedBox(
                  width: 330,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        width: 330,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Text(
                          'Account Settings',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 290,
                        height: 175,
                        margin: const EdgeInsets.only(right: 15, left: 15,),
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          color: Color.fromRGBO(179, 179, 179, 0.965)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 190,
                              child: Row(
                                children: [
                                  Text(
                                    'Name'
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [

                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [

                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [

                                ],
                              ),
                            ),
                          ],
                        )
                      )
                    ],
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
