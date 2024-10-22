import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

// CODE AREA

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
                CategoryLabel(
                    label: 'Hotels',
                    fontSize: 11.0.sp), // Specify font size here
              ],
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                    image: foodIcon,
                    oppressed: () => AppRoutes.navigateTofoodArea(context)),
                CategoryLabel(label: 'Food Place', fontSize: 11.0.sp),
              ],
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                  image: beachIcon,
                  oppressed: () => {AppRoutes.navigateToBeachesScreen(context)},
                ),
                CategoryLabel(label: 'Beaches', fontSize: 11.0.sp),
              ],
            ),
            Column(
              children: [
                BlueIconButtonDefault(
                  image: festivalIcon,
                  oppressed: () =>
                      {AppRoutes.navigateToFestivalsScreen(context)},
                ),
                CategoryLabel(
                    label: 'Festivals and \nEvents', fontSize: 11.0.sp),
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
  final double fontSize; // Add fontSize parameter of the categories

  const CategoryLabel({
    super.key,
    required this.label,
    this.fontSize = 14.0, // Default font size
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w, bottom: 5.h),
      child: SizedBox(
        height: 35.h,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500, // Use the fontSize parameter here
          ),
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
          padding: const EdgeInsets.symmetric(
              horizontal: 9.0), // Add padding to left and right
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  // Text area for the categories, Popular places, food places, and Festival and events.
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
