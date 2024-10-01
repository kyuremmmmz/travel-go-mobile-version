import 'package:flutter/material.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food_place.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String festivalIcon = "assets/images/icon/food.png";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    image: hotelIcon,
                    oppressed: () =>
                        {AppRoutes.navigateToHotelScreen(context)}),
                const CategoryLabel(label: 'Hotels'),
              ],
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                    image: foodIcon,
                    oppressed: () => AppRoutes.navigateTofoodArea(context)),
                const CategoryLabel(label: 'Food Place'),
              ],
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                  image: beachIcon,
                  oppressed: () => {AppRoutes.navigateToBeachesScreen(context)},
                ),
                const CategoryLabel(label: 'Beaches'),
              ],
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                  image: festivalIcon,
                  oppressed: () =>
                      {AppRoutes.navigateToFestivalsScreen(context)},
                ),
                const CategoryLabel(label: 'Festivals and \nEvents'),
              ],
            ),
          ],
        ),
      ],
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
