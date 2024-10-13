import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';

class TitleMenu extends StatefulWidget {
  const TitleMenu({super.key});

  @override
  State<TitleMenu> createState() => _TitleMenuState();
}

class _TitleMenuState extends State<TitleMenu> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> place = [];
  final data = Data();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'TRAVEL GO', // The home Travel Go Icon
          style: TextStyle(
            fontSize: 30.sp,
            color: const Color(0xFF44CAF9),
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(2.0.h, -2.0.h), // Position of the shadow (x, y)
                blurRadius: 20, // Blur effect of the shadow
                color: const Color.fromARGB(
                    128, 117, 116, 116), // Shadow color with opacity
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 59.0.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 12.h), // the top padding for image
                  Image.asset(
                    'assets/images/icon/placeholder.png',
                    width: 13.w,
                    height: 13.h,
                  ),
                  SizedBox(height: 20.h), // the bottom padding for image
                ],
              ),
              SizedBox(width: 5.w), // Space between image and text
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 12.h), // top padding for text
                  Text(
                    "Northwestern part of Luzon Island, Philippines",
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  SizedBox(height: 40.h), // bottom padding for text
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
