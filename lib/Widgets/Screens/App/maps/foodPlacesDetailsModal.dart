import 'package:TravelGo/Controllers/NetworkImages/food_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodPlacesDetailsModal extends StatefulWidget {
  final int id;
  final String? price;
  const FoodPlacesDetailsModal({super.key, required this.id, this.price});

  @override
  State<FoodPlacesDetailsModal> createState() => _FoodPlacesDetailsModalState();
}

class _FoodPlacesDetailsModalState extends State<FoodPlacesDetailsModal> {
  late FoodAreaBackEnd images = FoodAreaBackEnd();
  String? foodAreaName;
  var price;
  String? located;
  String? description;
  var dine = <String, dynamic>{};
  var imageUrlForDine = <String, dynamic>{};

  Future<void> places(int id) async {
    final data = await images.getSpecificData(id);
    setState(() {
      foodAreaName = data?['img'];
      price = data?['price'];
      located = data?['located'];
      description = data?['description'];
      id = data?['id'];
      for (var i = 1; i <= 20; i++) {
        final dineT = 'dine$i';
        final dineImg = 'dineUrl$i';
        final img = data?[dineT];
        final imgUrl = data?[dineImg];
        if (img != null) {
          dine[dineT] = img;
          imageUrlForDine[dineT] = imgUrl;
          print(imageUrlForDine);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    places(widget.id);
  }

  @override
  build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 30.h),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Text(
                  'Place Details',
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(height: 10.h),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    foodAreaName ?? 'No data available',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'About',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Text(
                    description ?? 'No Description',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Accomodations',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                    children: imageUrlForDine.entries.map((entry) {
                  return Column(
                    children: [
                      SizedBox(height: 20.h),
                      Stack(
                        children: [
                          Container(
                            height: 150.h,
                            width: 350.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(entry.value ?? ''),
                              ),
                              color: Colors.blue,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.12),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: Text(
                                dine[entry.key] ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList()),
                SizedBox(height: 30.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
