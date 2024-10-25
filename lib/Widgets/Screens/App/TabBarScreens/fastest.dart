import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';

class Fastest extends StatefulWidget {
  final int id;
  const Fastest({super.key, required this.id});

  @override
  State<Fastest> createState() => _FastestState();
}

class _FastestState extends State<Fastest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scrollbar(
      child: SingleChildScrollView(
        child: Stack(children: [
          const Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TitleMenu(),
            ],
          ),
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(
                height: 150,
              ),
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 195, 213, 245),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      padding: null,
                      height: 50,
                      width: 207,
                      child: const Center(
                        child: Text(
                          'Choose your Flight',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.only(right: 70),
                child: Card(
                    margin: EdgeInsets.zero,
                    color: const Color.fromARGB(255, 223, 234, 252),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        side: BorderSide(color: Colors.black)),
                    child: Container(
                      padding: null,
                      width: 280,
                      height: 50,
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Fastest',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Flexible ticket upgrade available',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    )),
              ),
              Container(
                padding: null,
                child: Card(
                    color: const Color.fromARGB(255, 232, 240, 253),
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                        side: BorderSide(color: Colors.black)),
                    child: Container(
                      padding: null,
                      child: Column(
                        children: [
                          Container(
                              padding: null,
                              width: 350,
                              height: 250,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 150),
                                    child: const Text(
                                      'Your Flight to Pangasinan ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/icon/food_place.png'),
                                          ),
                                          Text('NAIA')
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: Column(
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    right: 50, top: 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 12),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            0),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const Text(
                                                                          '12:05',
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Container(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 0),
                                                                          child:
                                                                              const Text(
                                                                            'PM',
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          null,
                                                                      child:
                                                                          const Text(
                                                                        'PANG . OCT 9',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                9),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .flight_takeoff,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              height: 2,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            const Icon(
                                                              Icons.flight_land,
                                                              size: 18,
                                                            ),
                                                          ],
                                                        )),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 0),
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  '12:05',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              0),
                                                                  child:
                                                                      const Text(
                                                                    'PM',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              padding: null,
                                                              child: const Text(
                                                                'PANG . OCT 9',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        9),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/icon/food_place.png'),
                                          ),
                                          Text('NAIA')
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: Column(
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    right: 50, top: 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 12),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            0),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const Text(
                                                                          '12:05',
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Container(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 0),
                                                                          child:
                                                                              const Text(
                                                                            'PM',
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          null,
                                                                      child:
                                                                          const Text(
                                                                        'PANG . OCT 9',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                9),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .flight_takeoff,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              height: 2,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            const Icon(
                                                              Icons.flight_land,
                                                              size: 18,
                                                            ),
                                                          ],
                                                        )),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 0),
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  '12:05',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              0),
                                                                  child:
                                                                      const Text(
                                                                    'PM',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              padding: null,
                                                              child: const Text(
                                                                'PANG . OCT 9',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        9),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'PHP 1,800',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 130,
                                        ),
                                        Container(
                                            padding: null,
                                            height: 30,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    side: const BorderSide(
                                                        color: Colors.black),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 203, 223, 240),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                onPressed: () {
                                                  AppRoutes
                                                      .navigateToBookingArea(
                                                          id: widget.id,
                                                          context);
                                                },
                                                child: const Text(
                                                  'Select',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )))
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )),
              ),
            ]),
          ),
        ]),
      ),
    ));
  }
}
