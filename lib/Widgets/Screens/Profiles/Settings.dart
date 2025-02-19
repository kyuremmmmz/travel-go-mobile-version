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
  bool _isRedirecting = false;

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
    _isRedirecting = true;
  }

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
          _isRedirecting = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          email = "error: $e";
          _isRedirecting = false;
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
      body: _isRedirecting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const TitleMenu(),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h), // Adjust padding as needed
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                insert('$uid');
                              },
                              child: Container(
                                width: 180
                                    .sp, // CircleAvatar diameter (2 * radius) + border width
                                height: 180.sp,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(
                                        0xFF44CAF9), // Set your desired border color
                                    width: 4.0, // Set your desired border width
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF44CAF9)
                                          .withOpacity(
                                              0.2), // Shadow color and opacity
                                      spreadRadius: 4, // Spread of the shadow
                                      blurRadius: 10, // Softness of the shadow
                                      offset: const Offset(0,
                                          4), // Positioning the shadow (x, y)
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 85
                                      .sp, // Adjust radius to fit within the border
                                  backgroundColor: Colors.grey[400],
                                  backgroundImage: _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : (img == null
                                              ? const AssetImage(
                                                  'assets/images/icon/user.png')
                                              : NetworkImage('$img'))
                                          as ImageProvider,
                                  child: _profileImage == null
                                      ? Icon(Icons.add_a_photo,
                                          size: 30.sp, color: Colors.white)
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 50.w), // Apply only right margin
                          child: buildSectionTitle(context, 'Account Settings'),
                        ),
                        buildAccountDetails(),
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 50.w), // Apply only right margin
                          child: buildSectionTitle(
                              context, 'Notification Settings'),
                        ),
                        buildNotificationSettings(),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 30.h), // Apply the desired right margin
                          child: SizedBox(
                            width: 140.sp, // Set your desired width here
                            height: 40.sp, // Set your desired height here
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
      padding: EdgeInsets.all(15.w),
      width: 330.sp,
      height: 50.sp,
      //decoration: BoxDecoration(
      //color: Color(0xFF44CAF9),
      // borderRadius: BorderRadius.circular(30),
      // ), just incase
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          height: 1,
          color: Color(0xFF44CAF9),
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
      height: 200.sp,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        border: Border.all(
          color: Colors.black,
          width: 0.5.w,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
            spreadRadius: 0, // How much the shadow spreads
            blurRadius: 4, // Softness of the shadow
            offset: Offset(0, 4), // Offset of the shadow (x, y)
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16.w), // Apply left and right padding to all children
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.h,
                      bottom: 0), // Adjust top and bottom padding here
                  child: Text('Name: ',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.h,
                      bottom: 0), // Adjust top and bottom padding here
                  child: Text(email ?? 'Unknown',
                      style: TextStyle(fontSize: 12.sp)),
                ),
              ],
            ),
            Divider(color: const Color(0xFF929292), thickness: 0.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Email: ',
                    style: TextStyle(
                        fontSize: 12.sp, fontWeight: FontWeight.bold)),
                Text(gmail ?? 'Unknown', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
            Divider(color: const Color(0xFF929292), thickness: 0.5.h),
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      currentAvatarUrl: img,
                      currentEmail: gmail,
                      currentName: email,
                    ),
                  ),
                )
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Edit Profile',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Divider(color: const Color(0xFF929292), thickness: 0.5.h),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Reset Password',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              onTap: () => showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: Text('Reset Password',
                            style: TextStyle(fontSize: 20.sp)),
                        content: SingleChildScrollView(
                            child: ListBody(children: <Widget>[
                          Text('You need to log out to reset your password.',
                              style: TextStyle(fontSize: 16.sp))
                        ])),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Log Out',
                                style: TextStyle(fontSize: 16.sp)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              AppRoutes.navigateToForgotPassword(context);
                              Usersss().signout(context);
                            },
                          ),
                          TextButton(
                            child: Text('Cancel',
                                style: TextStyle(fontSize: 16.sp)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildAccountInfoRow(String label, String value) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 15.w),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(label),
  //         Text(value),
  //       ],
  //     ),
  //   );
  // }

  Widget buildNotificationSettings() {
    // NOTIFICATION SETTINGS INFO AREA
    return Container(
      width: 390.w,
      height: 200.sp,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        border: Border.all(
          color: Colors.black,
          width: 0.5.w,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
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
              onTap: () => 'test',
              child: Padding(
                // Add padding only around "About"
                padding: EdgeInsets.only(top: 10.h, bottom: 0),
                child: Row(
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.black, thickness: 0.5.h),
            InkWell(
              onTap: () => 'test',
              child: Row(
                children: [
                  Text(
                    'Rate Our App',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black, thickness: 0.5.h),
            InkWell(
              onTap: () => 'test',
              child: Row(
                children: [
                  Text(
                    'Contact',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black, thickness: 0.5.h),
            InkWell(
              onTap: () => 'test',
              child: Row(
                children: [
                  Text(
                    'Share with Friends',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
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
