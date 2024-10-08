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
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Card(
                        color: const Color.fromARGB(255, 195, 213, 245),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 0, 0, 0)
                          ),
                          borderRadius: BorderRadius.circular(
                            10
                          )
                        ),
                        child: Container(
                          padding: null,
                          height: 50,
                          width: 207,
                          child: const Center(
                            child: Text(
                            'Choose your Flight',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ),
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