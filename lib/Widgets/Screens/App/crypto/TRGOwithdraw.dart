import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Trgowithdraw extends StatefulWidget {
  const Trgowithdraw({super.key});

  @override
  State<Trgowithdraw> createState() => _TrgowithdrawState();
}

class _TrgowithdrawState extends State<Trgowithdraw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRGOYALTY WALLET'),
      ),
      drawer: const DrawerMenuWidget(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: null,
              child: const Text(
                'YOUR TRGOYALTY POINTS '
                , 
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 48, 47, 47),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            
            Container(
              padding: null,
              child: Row(
                children: [
                  const SizedBox(
                    width: 110,
                  ),
                  Container(
                    padding: null,
                    child: const Text('1260',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black,
                    ),),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: null,
                    child: const Text('points',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () => debugPrint('test'), 
                child: const Text(
                  'Withdraw Points',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )
              ),
              const SizedBox(
                height: 20,
              ),
            Row(
              children: [
                
                Container(
                  height: 120,
                  width: 200,
                  child: Card(
                    color: const Color.fromARGB(252, 34, 90, 212),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.all(
                          10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  'Browse All Rewards',
                                  style:TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            SizedBox(
                                  width: 10),
                              CircleAvatar(
                                backgroundColor: Colors
                                    .white,
                                child: ClipOval(
                                  child: FaIcon(
                                    FontAwesomeIcons.gift
                                  )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  10), 
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 120,
                  width: 200,
                  child: Card(
                    color: const Color.fromARGB(252, 34, 90, 212),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Text(
                                  'How to get Points?',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  child: Image.asset('assets/images/Icon/coin.png'),
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}