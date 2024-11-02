import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:flutter/material.dart';

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
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 120,
                  width: 200,
                  child: Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Text(
                                  'Browse All Rewards',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 10),
                              CircleAvatar(
                                backgroundColor: Colors
                                    .white, 
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/icon/newlogo-crop.png',
                                    width: 30,
                                    height: 30, 
                                    fit: BoxFit.cover, 
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height:
                                  10), 
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 200,
                  child: Card(
                    color: Colors.blue,
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
                                  'Browse All Rewards',
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
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/icon/newlogo-crop.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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