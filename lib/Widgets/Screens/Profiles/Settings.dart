import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:TravelGo/Widgets/Screens/Profiles/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil for responsive
import 'dart:io';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

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
  File? _profileImage;
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
        // title: const Text('Settings'), //SETTINGS AREA JUST IN CASE PALAGYAN
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
                  const TitleMenu(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        insert('$uid');
                      },
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : (img == null
                                ? const AssetImage(
                                    'assets/images/icon/user.png')
                                : NetworkImage('$img')) as ImageProvider,
                        child: _profileImage == null
                            ? const Icon(Icons.add_a_photo,
                                size: 30, color: Colors.white) // the photo
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  buildSectionTitle(context, 'Account Settings'),
                  buildAccountDetails(),
                  const SizedBox(height: 30),
                  buildSectionTitle(context, 'Notification Settings'),
                  buildNotificationSettings(),
                  const SizedBox(height: 30),
                  BlueButtonWithoutFunction(
                    text: const Text('Back',
                        style: TextStyle(color: Colors.white)),
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromRGBO(68, 202, 249, 100))),
                    oppressed: () {
                      Navigator.pop(context);
                      AppRoutes.navigateToMainMenu(context);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    // DESIGN ARE OF THE ACCOUNT AND NOTIFICATION TEXT
    return Container(
      padding: const EdgeInsets.all(15),
      width: 330,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFF44CAF9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          height: 0,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget buildAccountDetails() {
    // ACCOUNT SETTINGS INFO AREA
    return Container(
      width: 290.w,
      height: 175.h,
      margin: EdgeInsets.only(right: 15.h, left: 15.h),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 241, 241, 100),
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildAccountInfoRow('Name', email ?? 'Unknown'),
          const Divider(
            color: Color(0xFF929292),
            thickness: 0.5,
          ),
          InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                            currentAvatarUrl: img,
                            currentEmail: gmail,
                            currentName: email,
                          )))
            },
            child: const Row(children: [Text('Edit Profile')]),
          ),
          const Divider(
            color: Color(0xFF929292),
            thickness: 0.5,
          ), // the edit profile line divider
          buildAccountInfoRow('Email:', gmail ?? 'Unknown'),
          const Divider(
            color: Color(0xFF929292),
            thickness: 0.5,
          ),
          InkWell(
            onTap: () => 'test',
            child: const Row(children: [Text('Change Password')]),
          ),
        ],
      ),
    );
  }

  Widget buildAccountInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  Widget buildNotificationSettings() {
    // NOTIFICATION SETTINGS INFO AREA
    return Container(
      width: 290,
      height: 175,
      margin: const EdgeInsets.only(right: 15, left: 15),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 241, 241, 100),
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => 'test',
            child: const Row(children: [Text('About')]),
          ),
          const Divider(color: Colors.black),
          InkWell(
            onTap: () => 'test',
            child: const Row(children: [Text('Rate My App')]),
          ),
          const Divider(color: Colors.black),
          InkWell(
            onTap: () => 'test',
            child: const Row(children: [Text('Contact')]),
          ),
          const Divider(color: Colors.black),
          InkWell(
            onTap: () => 'test',
            child: const Row(children: [Text('Share with Friends')]),
          ),
        ],
      ),
    );
  }
}