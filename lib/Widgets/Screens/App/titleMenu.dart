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
    return Container(
      // color: Colors.white, // Add your desired background color here just incase po
      child: Column(
        children: [
          Align(
            child: Image.asset(
              'assets/images/icon/newlogo2.png',
              fit: BoxFit.cover,
              height: 80.w, // height with screenutil width to avoid stretch
              width: 200.w,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/icon/placeholder.png',
                    width: 12.sp,
                    height: 12.sp,
                  ),
                  SizedBox(height: 10.h), // the bottom padding for image
                ],
              ),
              SizedBox(width: 5.w), // Space between image and text
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Northwestern part of Luzon Island, Philippines",
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  SizedBox(height: 10.h), // bottom padding for text
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
