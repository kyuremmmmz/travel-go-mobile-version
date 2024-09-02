import 'package:flutter/material.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/PlaceButtonSquare.dart';

void main() {
  runApp(const MainMenu());
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                Text(
                  'TRAVEL GO',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: const Offset(3.0, 3.0),
                        blurRadius: 4.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Northwestern part of Luzon Island, Philippines",
                  style: TextStyle(fontSize: 16), // Adjust text style as needed
                ),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: <Widget>[
                          const DismissableFindMoreLocation(),
                          CategorySelect(
                            label: "Categories",
                            oppressed: () => print('Categories clicked'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: beachIcon,
                                    oppressed: () => print('Hotels clicked'),
                                  ),
                                  const CategoryLabel(label: 'Hotels'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: foodIcon,
                                    oppressed: () =>
                                        print('Food Place clicked'),
                                  ),
                                  const CategoryLabel(label: 'Food Place'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: beachIcon,
                                    oppressed: () => print('Beaches clicked'),
                                  ),
                                  const CategoryLabel(label: 'Beaches'),
                                ],
                              ),
                              Column(
                                children: [
                                  BlueIconButtonDefault(
                                    image: hotelIcon,
                                    oppressed: () => print('Festivals clicked'),
                                  ),
                                  const CategoryLabel(
                                      label: 'Festivals and \nEvents'),
                                ],
                              ),
                            ],
                          ),
                          CategorySelect(
                            label: "Popular Places",
                            oppressed: () => print('Popular Places clicked'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Popular Place clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Popular Place clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Popular Place clicked'),
                              ),
                            ],
                          ),
                          CategorySelect(
                            label: "Food Places",
                            oppressed: () => print('Food Places clicked'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Food Place clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Food Place clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Food Place clicked'),
                              ),
                            ],
                          ),
                          CategorySelect(
                            label: "Festival and Events",
                            oppressed: () =>
                                print('Festival and Events clicked'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Event clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Event clicked'),
                              ),
                              PlaceButtonSquare(
                                place: 'Hundred Island',
                                image: Image.asset(hundredIsland).image,
                                oppressed: () => print('Event clicked'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryLabel extends StatelessWidget {
  final String label;
  const CategoryLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: 50,
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DismissableFindMoreLocation extends StatefulWidget {
  const DismissableFindMoreLocation({super.key});

  @override
  _DismissableFindMoreLocationState createState() =>
      _DismissableFindMoreLocationState();
}

class _DismissableFindMoreLocationState
    extends State<DismissableFindMoreLocation> {
  bool _isVisible = true;
  final String xButtonIcon = "assets/images/icon/ButtonX.png";
  final String adventureIcon = "assets/images/icon/adventure.png";

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Center(
            child: Container(
              height: 180,
              width: 380,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '  Find more location\n  around you',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '    Find your next adventure around Pangasinan \n    and create unforgettable memories!',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () => print('test'),
                                child: Stack(
                                  children: [
                                    const Text(
                                      '    Explore now',
                                      style:  TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        decoration: TextDecoration.none, // Disable the default underline
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 10,
                                      right: 0,
                                      child: Container(
                                        height: 2, 
                                        color: Colors.white, 
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: 100,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                iconSize: 20,
                                icon: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(xButtonIcon),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isVisible = false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset(adventureIcon),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}

class CategorySelect extends StatelessWidget {
  final String label;
  final VoidCallback oppressed;

  const CategorySelect({
    super.key,
    required this.label,
    required this.oppressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: oppressed,
              child: const Text(
                'View all',
                style: TextStyle(
                  color: Color.fromRGBO(33, 150, 243, 100),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
