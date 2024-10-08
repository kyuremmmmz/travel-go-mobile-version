import 'package:flutter/material.dart';
import 'package:itransit/Routes/Routes.dart';
import 'package:itransit/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

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
          oppressed: () => debugPrint('Categories clicked'),
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
                const CategoryLabel(label: 'Festivals and \nEventss'),
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
      padding: EdgeInsets.only(top: 8.w),
      child: SizedBox(
        height: 50.h,
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
      SizedBox(height: 30.h),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0), // Add padding to left and right
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle( // Text area for the categories, Popular places, food places, and Festival and events. 
                fontWeight: FontWeight.bold,
                fontSize: 16.sp, // Add font size
              ),
            ),
            GestureDetector(
              onTap: oppressed,
              child: const Text(
                'View all',
                style: TextStyle(
                  color: Color(0xFF2196F3),
                  fontWeight: FontWeight.bold,
                  fontSize: 13, // Add font size
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
}
