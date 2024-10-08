import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Drawer/drawerMenu.dart';

class Flight extends StatefulWidget {
  const Flight({super.key});

  @override
  State<Flight> createState() => _FlightState();
}

class _FlightState extends State<Flight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your available Flights'),
      ),
      drawer: const DrawerMenuWidget(),
      body: SafeArea(
        child:  SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Container(
                  child: const Text(
                    'Travel Go'
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}