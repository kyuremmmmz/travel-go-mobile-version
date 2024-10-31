  import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/GreyedListButton.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness

// CODE AREA

// ignore: must_be_immutable
class Categories extends StatefulWidget {
  late String? category;
  Categories({super.key, this.category});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food_place.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String festivalIcon = "assets/images/icon/food.png";
  final String planeIcon = "assets/images/icon/plane.png";
  late bool inHotelList = false;
  late bool inFoodList = false;
  late bool inBeachList = false;
  late bool inFestivalList = false;

  @override
  Widget build(BuildContext context) {
    checkCategory();
    return Column(
      children: [
        CategorySelect(
          label: "Categories",
          oppressed: () => debugPrint('Categories clicked'),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.sp)),
              color: Colors.grey[100],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    inHotelList
                        ? GreyedButton(image: hotelIcon)
                        : BlueIconButtonDefault(
                            image: hotelIcon,
                            oppressed: () =>
                                {AppRoutes.navigateToHotelScreen(context)}),
                    CategoryLabel(
                        label: 'Hotels',
                        fontSize: 11.0.sp), // Specify font size here
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    inFoodList
                        ? GreyedButton(image: foodIcon)
                        : BlueIconButtonDefault(
                            image: foodIcon,
                            oppressed: () =>
                                AppRoutes.navigateTofoodArea(context)),
                    CategoryLabel(label: 'Food Place', fontSize: 11.0.sp),
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    inBeachList
                        ? GreyedButton(image: beachIcon)
                        : BlueIconButtonDefault(
                            image: beachIcon,
                            oppressed: () =>
                                {AppRoutes.navigateToBeachesScreen(context)},
                          ),
                    CategoryLabel(label: 'Beaches', fontSize: 11.0.sp),
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    inFestivalList
                        ? GreyedButton(image: festivalIcon)
                        : BlueIconButtonDefault(
                            image: festivalIcon,
                            oppressed: () =>
                                {AppRoutes.navigateToFestivalsScreen(context)},
                          ),
                    CategoryLabel(
                        label: 'Festivals and \nEvents', fontSize: 11.0.sp),
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    BlueIconButtonDefault(
                      image: planeIcon,
                      oppressed: () =>
                          {AppRoutes.nagigateToFlightScreen(context)},
                    ),
                    CategoryLabel(label: 'Flights', fontSize: 11.0.sp),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void checkCategory() {
    switch (widget.category) {
      case 'hotel':
        inHotelList = true;
        break;
      case 'foodplace':
        inFoodList = true;
        break;
      case 'beach':
        inBeachList = true;
        break;
      case 'festival':
        inFestivalList = true;
        break;
    }
  }
}

class CategoryLabel extends StatelessWidget {
  final String label;
  final double fontSize; // Add fontSize parameter of the categories

  const CategoryLabel({
    super.key,
    required this.label,
    this.fontSize = 14.0, // Default font size for vehicleAvailability
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.w),
      child: SizedBox(
        height: 30.w,
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
            ],
          ),
        ),
        SizedBox(height: 10.w),
      ],
    );
  }
}
