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
        toolbarHeight: 40,
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
      body: SafeArea(
        child:  SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Container(
                  child: const Text(
                    'Travel Go',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                            'Northwestern part of Luzon Island, Philippines',
                            style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Card(
                        
                        shape: RoundedRectangleBorder(
                          
                          borderRadius: BorderRadius.circular(
                            50
                          )
                        ),
                        child: const Text('Choose your flight'),
                      ),
                    )
                  ]
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}