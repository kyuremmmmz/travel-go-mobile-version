import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({super.key});

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  String? email;
  String? img;
  late Usersss users = Usersss();
  List<Map<String, dynamic>> place = [];
  final data = Data();

  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users.fetchUser();
      if (useremail.isNotEmpty) {
        setState(() {
          email = useremail[0]['full_name'].toString();
          img = useremail[0]['avatar_url'].toString();
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

  Future<void> fetchImage() async {
    final datas = await data.fetchImageandText();
    setState(() {
      place = datas;
    });
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchImage();
  }

  @override // 3 LINES BUTTON AREA
  Widget build(BuildContext context) {
    return Drawer(
      width: 300.w,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 220.0,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: img == null
                        ? const AssetImage('assets/images/icon/newicon.png')
                        : NetworkImage('$img'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // ignore: unnecessary_null_comparison
                    email != null ? '$email' : 'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, size: 20.sp),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () {
              Navigator.pop(context);
              AppRoutes.navigateToDiscountArea(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.home, size: 20.sp),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () {
              Navigator.pop(context);
              AppRoutes.navigateToMainMenu(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.history, size: 20.sp),
            title: Text(
              'Recent Bookings',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () {
              Navigator.pop(context);
              AppRoutes.navigateToBookingHistory(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 20.sp),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () {
              Navigator.pop(context);
              AppRoutes.navigateToAccountSettings(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, size: 20.sp),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 16.sp),
            ),
            onTap: () {
              Navigator.pop(context);
              AppRoutes.navigateToLogin(context);
              Usersss().signout(context);
            },
          ),
        ],
      ),
    );
  }
}
