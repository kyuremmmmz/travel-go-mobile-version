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
                  oppressed: () => print('Motorcycle clicked'),
                ),
                CategoryLabel(
                    label: hasMotor == "true" ? 'Motorcycle' : 'Unavailable'),
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
