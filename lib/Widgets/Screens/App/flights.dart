import 'package:flutter/material.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';

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
        child:  Scrollbar(
          child: SingleChildScrollView(
            child: 
              Stack(
                children: [
                  Center(
                  child: Container(
                  padding: null,
                  child: const Text(
                    'TRAVEL GO',
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
                    ),
                    const SizedBox(
                      height: 50,
                      ),
                    Container(
                      padding: const EdgeInsets.only(
                        right: 100
                      ),
                      child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)
                            ),
                            side: BorderSide(
                              color: Colors.black
                            )
                          ),
                          child: Container(
                          width: 280,
                          height: 50,
                          child: const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text('Best',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Flexible ticket upgrade available',
                                style: TextStyle(
                                  color: Colors.green
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    )
                    ]
                  ),
                ),
              ]
            ),
          ),
        )
      )
    );
  }
}