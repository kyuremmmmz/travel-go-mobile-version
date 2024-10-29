import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:TravelGo/Widgets/Screens/App/categories.dart';
import 'package:flutter/material.dart';

class VehicleAvailability extends StatefulWidget {
  final int text;

  const VehicleAvailability({super.key, required this.text});

  @override
  State<VehicleAvailability> createState() => _VehiclAavailabilityState();
}

class _VehiclAavailabilityState extends State<VehicleAvailability> {
  String? description;
  String? text;
  String? imageUrl;
  String? hasCar;
  String? hasMotor;
  String? located;
  String? price;
  String? availability;
  final data = Data();

  void showModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
              height: 700,
              width: 700,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Caculate my Trip Powered by Gemini AI',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration:   const InputDecoration(
                      labelText: 'Origin',
                      filled: true,
                      fillColor:  Color.fromARGB(255, 235, 242, 247),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue
                        )
                      ),
                    ),
                  ),
                  
                  Center(
                    child: Container(
                        height: 50,
                        width: 2,
                        color: Colors.black,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Destination',
                      filled: true,
                      fillColor: Color.fromARGB(255, 235, 242, 247),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  Center(
                    child: Card(
                      color: const Color.fromARGB(255, 235, 242, 247),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20
                        )
                      ),
                      child:  Container(
                        height: 50,
                        width: 200,
                        margin: const EdgeInsets.only(
                          top: 20
                        ),
                        child: const Text(
                          textAlign: TextAlign.center,
                          '5 hours',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                          ),
                        ),
                      )
                    )
                  )
                ],
              ));
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(right: 170),
        child: const Text(
          'Vehicle Availability',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: [
                BlueIconButtonDefault(
                  image: 'assets/images/icon/tricycle.png',
                  oppressed: () => print('Tricycle clicked'),
                ),
                const CategoryLabel(label: 'Tricycle'),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                    image: 'assets/images/icon/motorbike.png',
                    oppressed: () => {
                      showModal(context)
                    }),
                const CategoryLabel(label: 'Motorcycle'),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                  image: 'assets/images/icon/plane.png',
                  oppressed: () => print('Planes clicked'),
                ),
                const CategoryLabel(label: 'Planes'),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                  image: 'assets/images/icon/bus.png',
                  oppressed: () => print('Bus or Van clicked'),
                ),
                CategoryLabel(
                    label: hasCar == "true" ? "Bus or Van" : "Unavailable"),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
