import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Screens/App/ResponsiveScreen/ResponsiveScreen.dart';
import 'package:TravelGo/Widgets/Screens/App/flights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreDetailsModal extends StatefulWidget {
  final int id;
  final String? price;
  const ExploreDetailsModal({super.key, required this.id, this.price});

  @override
  State<ExploreDetailsModal> createState() => _ExploreDetailsModalState();
}

class _ExploreDetailsModalState extends State<ExploreDetailsModal> {
  late Data images = Data();
  String? placeName;
  var price;
  String? located;
  String? description;
  var amenities = <String, dynamic>{};
  var imageUrlForAmenities = <String, dynamic>{};

  Future<void> places(int id) async {
    final data = await images.fetchSpecificDataInSingle(id);
    setState(() {
      placeName = data?['place_name'];
      price = data?['price'];
      located = data?['locatedIn'];
      description = data?['description'];
      id = data?['id'];
      for (var i = 1; i <= 20; i++) {
        final key = 'amenity$i';
        final keyUrl = 'amenity${i}Url';
        final value = data?[key];
        final imageUrlValue = data?[keyUrl];
        if (value != null) {
          amenities[key] = value;
          imageUrlForAmenities[key] = imageUrlValue;
          print(imageUrlForAmenities);
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
                    placeName ?? 'No data available',
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
                    'Amenities',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                    children: imageUrlForAmenities.entries.map((entry) {
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
                                amenities[entry.key] ?? '',
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
                SizedBox(height: 30.h),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'PHP ${price.toString()} - 6,000',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Responsive().headerFontSize(),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: '\nEstimated Expenses',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: Responsive().aboutFontSize()))
                        ])),
                        BlueButtonWithoutFunction(
                            text: Text(
                              'See Tickets',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Responsive().aboutFontSize(),
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            oppressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Flight(
                                            id: widget.id,
                                          )));
                            })
                      ],
                    )),
                SizedBox(height: 10.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
