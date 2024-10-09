// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';

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
  String? gmail;
  String? uid;
  String? img;
  late Usersss users = Usersss();
  List<Map<String, dynamic>> place = [];
  final data = Data();
  late bool isPaymentSuccess = false;
  final supabase = Supabase.instance.client;

  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users.fetchUser();
      final userEmail = supabase.auth.currentUser!.email;
      final userId = supabase.auth.currentUser!.id;
      if (mounted) {
        setState(() {
          email = useremail.isNotEmpty
              ? useremail[0]['full_name'].toString()
              : "Anonymous User";
          gmail = userEmail;
          uid = userId;
          img = useremail.isNotEmpty
              ? useremail[0]['avatar_url'].toString()
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


  Future<Future<String?>> insert(String id) async {
    final response = users.editProfile(id);
    return response;
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
        title: const Text('Settings'),
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
            child: SingleChildScrollView(
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
                    style:
                        TextStyle(fontSize: 16), // Adjust text style as needed
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Container(
                          padding: null,
                          child: GestureDetector(
                            onTap: () {
                              insert('$uid');
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage('$img'),
                            ),
                          ))),
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: 330,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(68, 202, 249, 100),
                              borderRadius: BorderRadius.circular(30)),
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
                            margin: const EdgeInsets.only(
                              right: 15,
                              left: 15,
                            ),
                            padding: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Color.fromRGBO(241, 241, 241, 100),
                                border: Border(
                                    right: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Name'),
                                      Text('$email')
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                InkWell(
                                    onTap: () => 'test',
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: const Row(
                                        children: [Text('Edit Profile')],
                                      ),
                                    )),
                                const Divider(
                                  color: Colors.black,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Email:'),
                                      Text('$gmail')
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                InkWell(
                                    onTap: () => 'test',
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: const Row(
                                        children: [Text('Change Password')],
                                      ),
                                    )),
                              ],
                            )),
                      ],
                    ),
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
                              color: const Color.fromRGBO(68, 202, 249, 100),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Text(
                            'Notification Settings',
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
                            margin: const EdgeInsets.only(
                              right: 15,
                              left: 15,
                            ),
                            padding: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Color.fromRGBO(241, 241, 241, 100),
                                border: Border(
                                    right: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: () => 'test',
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: const Row(
                                        children: [Text('About')],
                                      ),
                                    )),
                                const Divider(
                                  color: Colors.black,
                                ),
                                InkWell(
                                    onTap: () => 'test',
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: const Row(
                                        children: [Text('Rate My App')],
                                      ),
                                    )),
                                const Divider(
                                  color: Colors.black,
                                ),
                                InkWell(
                                    onTap: () => 'test',
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: const Row(
                                        children: [Text('Contact')],
                                      ),
                                    )),
                                const Divider(
                                  color: Colors.black,
                                ),
                                InkWell(
                                    onTap: () => 'test',
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: const Row(
                                        children: [Text('Share with Friends')],
                                      ),
                                    )),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlueButtonWithoutFunction(
                    text: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                      Color.fromRGBO(68, 202, 249, 100),
                    )),
                    oppressed: () {
                      Navigator.pop(context);
                      AppRoutes.navigateToMainMenu(context);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
