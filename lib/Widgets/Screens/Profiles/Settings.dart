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
  String? eemail;
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
          eemail = useremail.isNotEmpty
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
          eemail = "error: $e";
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
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const TitleMenu(),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.h), // Adjust padding as needed
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          insert('$uid');
                        },
                        child: CircleAvatar(
                          radius: 45.sp,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : (img == null
                                  ? const AssetImage(
                                      'assets/images/icon/user.png')
                                  : NetworkImage('$img')) as ImageProvider,
                          child: _profileImage == null
                              ? Icon(Icons.add_a_photo,
                                  size: 30.sp, color: Colors.white) // the photo
                              : null,
                        ),
                      ),
                    ),
                  ),
                  buildSectionTitle(context, 'Account Settings'),
                  buildAccountDetails(),
                  SizedBox(height: 30.h),
                  buildSectionTitle(context, 'Notification Settings'),
                  buildNotificationSettings(),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 30.h), // Apply the desired right margin
                    child: Container(
                      width: 140.w, // Set your desired width here
                      // height: 40.h, // Set your desired height here
                      child: BlueButtonWithoutFunction(
                        text: Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color(0xFF44CAF9),
                          ),
                        ),
                        oppressed: () {
                          Navigator.pop(context);
                          AppRoutes.navigateToMainMenu(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
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
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(15.w),
      height: 50.h,
      //decoration: BoxDecoration(
      //color: Color(0xFF44CAF9),
      // borderRadius: BorderRadius.circular(30),
      // ), just incase
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          height: 1,
          color: const Color(0xFF44CAF9),
          fontWeight: FontWeight.w800,
          fontSize: 18.sp,
        ),
      ),
    );
  }

  Widget buildAccountDetails() {
    // ACCOUNT SETTINGS INFO AREA
    return Container(
      width: 390.w,
      margin: EdgeInsets.symmetric(horizontal: 13.w),
      padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        border: Border.all(
          color: Colors.black,
          width: 0.5.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildAccountInfoRow('Name', eemail ?? 'Unknown'),
          Divider(color: const Color(0xFF929292), thickness: 0.5.h),
          InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                            currentAvatarUrl: img,
                            currentEmail: gmail,
                            currentName: eemail,
                          )))
            },
            child: Row(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text('Edit Profile',
                      style: TextStyle(fontSize: 16.sp, color: Colors.blue)))
            ]),
          ),
          Divider(
              color: const Color(0xFF929292),
              thickness: 0.5.h), // the edit profile line divider
          buildAccountInfoRow('Email:', gmail ?? 'Unknown'),
          Divider(color: const Color(0xFF929292), thickness: 0.5.h),
          InkWell(
            onTap: () => print('test Change Password'),
            child: Row(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text('Change Password',
                      style: TextStyle(fontSize: 16.sp, color: Colors.blue)))
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildAccountInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(5.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16.sp)),
          Text(value, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget buildNotificationSettings() {
    // NOTIFICATION SETTINGS INFO AREA
    return Container(
      width: 390.w,
      margin: EdgeInsets.symmetric(horizontal: 13.w),
      padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        border: Border.all(
          color: Colors.black,
          width: 0.5.w,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.sp),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
            spreadRadius: 0, // How much the shadow spreads
            blurRadius: 4, // Softness of the shadow
            offset: const Offset(0, 4), // O
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16.w), // Apply left and right padding to all children
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => print('test About'),
              child: Padding(
                // Add padding only around "About"
                padding: EdgeInsets.only(top: 10.h, bottom: 0),
                child: Row(
                  children: [
                    Text('About',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.black, thickness: 0.5.h),
            InkWell(
              onTap: () => print('test Rate My App'),
              child: Row(
                children: [
                  Text('Rate My App',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Divider(color: Colors.black, thickness: 0.5.h),
            InkWell(
              onTap: () => print('test Contact'),
              child: Row(
                children: [
                  Text(
                    'Contact',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black, thickness: 0.5.h),
            InkWell(
              onTap: () => print('test Share with Friends'),
              child: Row(
                children: [
                  Text(
                    'Share with Friends',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
