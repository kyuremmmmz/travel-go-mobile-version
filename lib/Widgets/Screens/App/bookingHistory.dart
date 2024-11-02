import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/Booking/BookingSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil for responsive

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const TitleMenu(),
            Text(
              'My Bookings',
              style: TextStyle(
                fontSize: 24.sp,
                color: const Color(0xFF534D4D),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.h), // Add space below 'My Bookings' text
            BookingSection(
              departureDay: '11th',
              departureDate: 'October, 2024, Monday',
              checkedInDate: 'October 12, 2024, 9:00 AM',
              price: 999900,
              locationName: 'The Monarch Hotel',
              locationAddress: 'Calasiao, Pangasinan, Philippines',
              oppressed: () => AppRoutes.navigateToHotelScreen(context),
            ),
          ],
        ),
      ),
    );
  }
}