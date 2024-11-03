// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:TravelGo/Controllers/NetworkImages/vouchers.dart';
import 'package:TravelGo/Widgets/Screens/App/comments/hotelComments.dart';
import 'package:TravelGo/Widgets/Screens/App/vehicleAvailability.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ResponsiveScreen/ResponsiveScreen.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/Searches/hotelSearch.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/BookingBackend/hotel_booking.dart';
import 'package:TravelGo/Controllers/NetworkImages/hotel_images.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelsInfo extends StatefulWidget {
  final int text;
  final String? name;
  final int id;
  final String? price;
  const HotelsInfo({
    super.key,
    required this.text,
    this.name,
    required this.id,
    this.price,
  });

  @override
  State<HotelsInfo> createState() => _HotelsInfoState();
}

class _HotelsInfoState extends State<HotelsInfo> {
  final _searchController = TextEditingController();
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  String? email;
  String? description;
  String? text;
  String? hasCar;
  String? imageUrl;
  String? hasMotor;
  String? located;
  String? availability;
  var price;
  var id;
  var amenities = <String, dynamic>{};
  var imageUrlForAmenities = <String, dynamic>{};
  final data = HotelImages();
  late Usersss users = Usersss();
  String? img;
  String? imgUrl;
  String? comments;
  StreamSubscription? supa;
  List vouchersList = [];
  bool _isRedirecting = false;
  final vouchers = Vouchers();
  final supabase = Supabase.instance.client;

  Future<void> fetchWithoutFunct() async {
    final response = await users.fetchUserWithoutgetter();
    setState(() {
      imgUrl = response[0]['avatar_url'];
    });
  }

  Future<void> update(int id) async {
    await vouchers.updateVoucherToclaim(id);
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchSpecificData(widget.text);
    fetchWithoutFunct();
    fetchDiscountReal();
    print(widget.name);
    _isRedirecting = true;
  }

  @override
  void dispose() {
    _searchController.dispose();
    supa?.cancel();
    super.dispose();
  }

  Future<void> fetchSpecificData(int id) async {
    try {
      final dataList = await data.fetchDataInSingle(id);

      if (dataList == null) {
        setState(() {
          _isRedirecting = false;
          description = "No description available";
        });
      } else {
        setState(() {
          _isRedirecting = false;
          description = dataList['hotel_description'];
          text = dataList['hotel_name'];
          id = dataList['id'];
          imageUrl = dataList['image'].toString();
          hasCar = dataList['car_availability'].toString();
          hasMotor = dataList['tricycle_availability'].toString();
          located = dataList['hotel_located'];
          price = dataList['hotel_price'];
          availability = dataList['availability'];
          for (var i = 1; i <= 20; i++) {
            final key = 'amenity$i';
            final keyUrl = 'amenity${i}Url';
            final value = dataList[key];
            final imageUrlValue = dataList[keyUrl];
            if (value != null) {
              amenities[key] = value;
              imageUrlForAmenities[key] = imageUrlValue;
              print(imageUrlForAmenities);
            }
          }
        });
      }
    } catch (e) {
      setState(() {
        _isRedirecting = false;
        description = "Error fetching data";
      });
      print('Error in fetchSpecificData: $e');
    }
  }

  Future<String?> getter(String image) async {
    final response =
        supabase.storage.from('hotel_amenities_url').getPublicUrl(image);
    if (response.isEmpty) {
      return 'null';
    }
    return response;
  }

  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users.fetchUser();
      if (useremail.isNotEmpty) {
        setState(() {
          email = useremail[0]['full_name'].toString();
        });
      } else {
        setState(() {
          email = "Anonymous User";
        });
      }
    } catch (e) {
      setState(() {
        email = "Error: $e";
      });
    }
  }

  Future<void> fetchDiscountReal() async {
    supa = supabase.from('discounts').stream(primaryKey: ['id']).listen(
        (List<Map<String, dynamic>> comment) async {
      await fetchDiscounts(comment);
    });
  }

  Future<void> fetchDiscounts(List<Map<String, dynamic>> name) async {
    final data = await vouchers.getTheDiscountsAsListOfLikeReal(name, '$text');
    setState(() {
      vouchersList = data;
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 40.h,
          leading: Builder(
            builder: (BuildContext context) => IconButton(
              icon: Icon(Icons.menu, size: 24.sp),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: const DrawerMenuWidget(),
        body: _isRedirecting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  const Positioned(
                    child: Column(
                      children: <Widget>[TitleMenu(), HotelSearchMenu()],
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: Responsive().infoSizePictureTop(),
                        child: Container(
                          height: Responsive().infoSizePictureHeight(),
                          width: Responsive().infoSizePictureWidth(),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageUrl != null &&
                                          imageUrl!.isNotEmpty
                                      ? NetworkImage(imageUrl!)
                                      : const AssetImage(
                                          'assets/images/places/PangasinanProvincialCapitol.jpg'))),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: Responsive().scrollableContainerInfoTop(),
                        child: Container(
                          padding: Responsive().containerPaddingTop(),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: Responsive().borderRadiusTop(),
                          ),
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Container(
                                  padding: Responsive().horizontalPadding(),
                                  child: Text(
                                    text ?? 'No data available',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Responsive().titleFontSize(),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 25.w),
                                    Icon(Icons.location_on,
                                        color: Colors.red,
                                        size: Responsive().headerFontSize()),
                                    GestureDetector(
                                        onTap: () {
                                          AppRoutes.navigateToHotelMapPage(
                                              context,
                                              name: '$located',
                                              id: widget.id);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              located ?? 'I cant locate it',
                                              style: TextStyle(
                                                  fontSize: Responsive()
                                                      .aboutFontSize(),
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.blue),
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons.map,
                                              size: Responsive()
                                                  .clickToOpenFontSize(),
                                              color: Colors.red,
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 30.w),
                                  child: Text(
                                    'About',
                                    style: TextStyle(
                                        fontSize: Responsive().headerFontSize(),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: Responsive().horizontalPadding(),
                                  child: Text(
                                    description ?? 'No Description',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: Responsive().aboutFontSize()),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 30.w),
                                  child: Text(
                                    'Amenities',
                                    style: TextStyle(
                                        fontSize: Responsive().headerFontSize(),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.sp)),
                                        color: Colors.grey[200],
                                      ),
                                      child: Row(
                                          children: imageUrlForAmenities.entries
                                              .map((entry) {
                                        return Row(
                                          children: [
                                            SizedBox(width: 30.w),
                                            Stack(
                                              children: [
                                                Container(
                                                  height: Responsive()
                                                      .amenitiesBoxHeight(),
                                                  width: Responsive()
                                                      .amenitiesBoxWidth(),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            entry.value ?? ''),
                                                      ),
                                                      color: Colors.blue,
                                                      borderRadius: Responsive()
                                                          .amenitiesBorderRadius()),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.sp),
                                                    decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.12),
                                                        borderRadius: Responsive()
                                                            .amenitiesTextBorderRadius()),
                                                    child: Text(
                                                      amenities[entry.key] ??
                                                          '',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }).toList()),
                                    )),
                                SizedBox(height: 30.h),
                                VehicleAvailability(text: widget.text, name: located,),
                                SizedBox(height: 30.h),
                                Column(
                                  children: [
                                    SizedBox(height: 10.h),
                                    HotelComments(text: widget.text),
                                    SizedBox(height: 20.h),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 30.w),
                                      child: Text(
                                        'Discount Vouchers Available',
                                        style: TextStyle(
                                          fontSize:
                                              Responsive().headerFontSize(),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: vouchersList.isEmpty
                                          ? Center(
                                              child: Text(
                                                  'No vouchers available for the $text'),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children:
                                                  vouchersList.map((item) {
                                                if (item['claimed'] ==
                                                    'not claimed') {
                                                  return GestureDetector(
                                                      onTap: () {
                                                        update(item['id']);
                                                      },
                                                      child: Container(
                                                        width: 200,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8.0),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.teal,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              offset:
                                                                  Offset(0, 4),
                                                              blurRadius: 8.0,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${item['discount']}% OFF',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8.0),
                                                            Text(
                                                              '${item['hotelName']}',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        31,
                                                                        20,
                                                                        20),
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 12.0),
                                                            const Text(
                                                              'Claim Voucher',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                } else {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      final cleanedPriceString =
                                                          price.replaceAll(
                                                              ',', '');
                                                      final int priceValue =
                                                          int.tryParse(
                                                                  cleanedPriceString) ??
                                                              0;
                                                      int discountPercentage =
                                                          item['discount'];
                                                      int discountAmount =
                                                          (priceValue *
                                                                  discountPercentage) ~/
                                                              100;
                                                      int finalPrice =
                                                          priceValue -
                                                              discountAmount;
                                                      final formattedPrice =
                                                          NumberFormat('#,##0')
                                                              .format(
                                                                  finalPrice);

                                                      setState(() {
                                                        price = formattedPrice;
                                                      });
                                                      vouchers.deleteDiscount(
                                                          item['id']);
                                                    },
                                                    child: Container(
                                                      width: 200,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.teal,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            offset:
                                                                Offset(0, 4),
                                                            blurRadius: 8.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${item['discount']}% OFF',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8.0),
                                                          Text(
                                                            '${item['hotelName']}',
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      31,
                                                                      20,
                                                                      20),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 12.0),
                                                          const Text(
                                                            'Use voucher',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }).toList(),
                                            ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                        padding:
                                            Responsive().horizontalPadding(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      'PHP ${price.toString()} - 6,000',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: Responsive()
                                                          .headerFontSize(),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '\nEstimated Expenses',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: Responsive()
                                                          .aboutFontSize()))
                                            ])),
                                            BlueButtonWithoutFunction(
                                                text: Text(
                                                  'Place Booking',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Responsive()
                                                          .aboutFontSize(),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                oppressed: () {
                                                  HotelBooking()
                                                      .passTheHotelData(
                                                          widget.text);
                                                  AppRoutes
                                                      .navigateToHotelBookingScreen(
                                                          context,
                                                          id: widget.text,
                                                          price: price);
                                                })
                                          ],
                                        )),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ));
  }
}