import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  mainAxisSize: MainAxisSize.min,
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
                        right: 70
                      ),
                      child: Card(
                          margin:  EdgeInsets.zero,
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
                          padding: null,
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
                    ),
                    Container(
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)
                          ),
                          side: BorderSide(
                            color: Colors.black
                          )
                        ),
                        child: Container(
                          padding: null,
                          child: Column(
                            children: [
                              Container(
                                  padding: null,
                                  width: 350,
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                        top: 10,
                                        right: 150),
                                        child: const Text(
                                        'Your Flight to Pangasinan ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Column(
                                              children: [
                                                CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/images/icon/food_place.png'),
                                                ),
                                                Text(
                                                  'NAIA'
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                bottom: 30
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(
                                                      right: 50,
                                                      top: 10
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                        '7:15',
                                                        style:  TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const Text(
                                                          'AM',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.only(
                                                            left: 12,
                                                            top: 12
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                              Icons.flight_takeoff,
                                                              size: 18,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                width: 50,
                                                                height: 2,
                                                                color: Colors.black,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              const Icon(
                                                              Icons.flight_land,
                                                              size: 18,
                                                              ),
                                                            ],
                                                          )
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.only(
                                                            bottom: 0
                                                          ),
                                                          child: const Text(
                                                        '12:05',
                                                        style:  TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.only(
                                                            bottom: 0
                                                          ),
                                                          child: const Text(
                                                              'PM',
                                                          style:  TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(
                                                      right: 210
                                                    ),
                                                    child: const Text(
                                                      'MNL . OCT 9',
                                                      style: TextStyle(
                                                        fontSize: 12
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ),
                              ],
                            ),
                          )
                        ),
                      ),
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