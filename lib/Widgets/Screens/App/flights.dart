import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/TabBarScreens/best.dart';
import 'package:TravelGo/Widgets/Screens/App/TabBarScreens/cheapest.dart';
import 'package:TravelGo/Widgets/Screens/App/TabBarScreens/fastest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Flight extends StatefulWidget {
  final int id;
  const Flight({super.key, required this.id});

  @override
  State<Flight> createState() => _FlightState();
}

class _FlightState extends State<Flight> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              tabs: [
                Tab(
                    height: 45.sp,
                    icon: Icon(Icons.airplane_ticket, size: 24.sp),
                    child: Text('Cheapest', style: TextStyle(fontSize: 13.sp))),
                Tab(
                    height: 45.sp,
                    icon: Icon(Icons.airplane_ticket, size: 24.sp),
                    child: Text('Best', style: TextStyle(fontSize: 13.sp))),
                Tab(
                    height: 45.sp,
                    icon: Icon(Icons.airplane_ticket, size: 24.sp),
                    child: Text('Fastest', style: TextStyle(fontSize: 13.sp))),
              ],
            ),
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
          body: TabBarView(children: [
            Cheapest(id: widget.id),
            Best(
              id: widget.id,
            ),
            Fastest(id: widget.id)
          ])),
    );
  }
}
