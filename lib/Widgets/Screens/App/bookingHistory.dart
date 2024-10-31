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
    // title: const Text('History'), //SETTINGS AREA JUST IN CASE PALAGYAN
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.h,
        //backgroundColor: Color(0xFFF1FCFF),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const DrawerMenuWidget(), // ditong area ang 3 lines
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const TitleMenu(),
            Text(
              'My Bookings',
              style: TextStyle(
                height: 5.h,
                fontSize: 18.sp,
                color: const Color(0xFF534D4D),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30.h),
            BookingSection(
              departureDay: '11th',
              departureDate: 'October, 2024, Monday',
              checkedInDate: 'October 12, 2024, 9:00 AM',
              price: 999900,
              locationName: 'The Monarch Hotel',
              locationAddress: 'Calasiao, Pangasinan, Philippines',
              oppressed: () => print('test'),
            ),
          ],
        ),
      ),
    );
  }
}
