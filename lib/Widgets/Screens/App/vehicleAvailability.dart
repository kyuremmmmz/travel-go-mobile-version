// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/TripCalculations/TripCalculate.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:TravelGo/Widgets/Screens/App/categories.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Import for StreamController

class VehicleAvailability extends StatefulWidget {
  final int text;
  String? name;
  VehicleAvailability({
    super.key,
    required this.text,
    this.name,
  });

  @override
  State<VehicleAvailability> createState() => _VehiclAavailabilityState();
}

class _VehiclAavailabilityState extends State<VehicleAvailability> {
  final origin = TextEditingController();
  final data = Data();
  final trips = Tripcalculate();
  final _resultController = StreamController<String?>();

  @override
  void dispose() {
    origin.dispose();
    _resultController.close();
    super.dispose();
  }

  Future<void> calculateTrip() async {
    final cal = await trips.calculateData(origin.text.trim(), '${widget.name}');
    final cleaN = cal?.replaceAll('##', '').replaceAll('**', '');
    _resultController.add(cleaN);
  }

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
                'Calculate my Trip Powered by Gemini AI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: origin,
                decoration: const InputDecoration(
                  labelText: 'Origin',
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    height: 50,
                    width: 500,
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      '${widget.name}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
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
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 235, 242, 247),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    height: 150,
                    width: 400,
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: StreamBuilder<String?>(
                      stream: _resultController.stream,
                      builder: (context, snapshot) {
                        return Text(
                          textAlign: TextAlign.center,
                          snapshot.data ?? 'Result will appear here',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    calculateTrip();
                  },
                  child: const Text('Calculate'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    oppressed: () => {showModal(context)},
                  ),
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
                  const CategoryLabel(
                    label: "Bus or Van",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
