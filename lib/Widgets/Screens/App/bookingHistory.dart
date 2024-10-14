import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:flutter/material.dart';

class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
        preferredSize: Size(50, 40), 
        child: Column(
          children: [
            Text(
                  'TRAVEL GO',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Northwestern part of Luzon Island, Philippines",
                  style: TextStyle(fontSize: 16),
                ),
            ],
          )
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'My Bookings',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 41, 39, 39),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                child: Container(
                  height: 220,
                  width: 350,
                  color: const Color.fromARGB(255, 181, 231, 247),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}