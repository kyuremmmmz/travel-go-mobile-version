// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:TravelGo/Controllers/NetworkImages/vouchers.dart';
import 'package:TravelGo/Widgets/Screens/App/hotelComments.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ResponsiveScreen/ResponsiveScreen.dart';
import 'package:TravelGo/Controllers/Ratings/ratingsBackend.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/hotelSearch.dart';
import 'package:flutter/material.dart';
import 'package:TravelGo/Controllers/BookingBackend/hotel_booking.dart';
import 'package:TravelGo/Controllers/NetworkImages/hotel_images.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelInformationScreen extends StatefulWidget {
  final int text;
  final String? name;
  final int id;
  final String? price;
  const HotelInformationScreen({
    super.key,
    required this.text,
    this.name,
    required this.id,
    this.price,
  });

  @override
  State<HotelInformationScreen> createState() => _HotelInformationScreenState();
}

class _HotelInformationScreenState extends State<HotelInformationScreen> {
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
  final _commentController = TextEditingController();
  var price;
  var id;
  var amenities = <String, dynamic>{};
  var imageUrlForAmenities = <String, dynamic>{};
  final data = HotelImages();
  late Usersss users = Usersss();
  String? img;
  String? imgUrl;
  String? comments;
  int userRatings = 0;
  double ratingsTotal = 0.0;
  late String commentType;
  int totalRatings = 0;
  int ratings = 0;
  String? commentImg;
  StreamSubscription? sub;
  StreamSubscription? supa;
  List<Map<String, dynamic>> list = [];
  List vouchersList = [];
  late RatingsAndComments rating = RatingsAndComments();
  bool _isRedirecting = false;
  final vouchers = Vouchers();
  final supabase = Supabase.instance.client;
  Future<void> commentInserttion() async {
    rating.postComment(_commentController.text.trim(), ratings,
        commentType = "hotel", '$text', widget.text, '$email', '$imgUrl');
  }

  Future<void> fetchWithoutFunct() async {
    final response = await users.fetchUserWithoutgetter();
    setState(() {
      imgUrl = response[0]['avatar_url'];
    });
  }

  Future<void> stateComments() async {
    final data = await rating.fetchComments(widget.text, 'hotel');
    final records = data.length;
    final count = totalRatings / records;
    setState(() {
      list = data;
      ratingsTotal = count;
      userRatings = records;
    });
  }

  void _realTimeFetch() {
    sub = supabase.from('ratings_and_comments').stream(
        primaryKey: ['id']).listen((List<Map<String, dynamic>> comment) async {
      await fetchRatings(comment);
    });
  }

  Future<void> update(int id) async {
    await vouchers.updateVoucherToclaim(id);
  }

  Future<void> fetchRatings(List<Map<String, dynamic>> data) async {
    try {
      final data = await rating.fetchComments(widget.text, 'hotel');
      final totalRatings = await rating.fetchRatingsAsSum();
      final records = data.length;

      if (records > 0) {
        final count = totalRatings / records;
        final validCount = count > 5.0 ? 5.0 : count;

        setState(() {
          _isRedirecting = false;
          list = data;
          ratingsTotal = validCount;
          userRatings = records;
          commentImg = imgUrl;
        });
      } else {
        setState(() {
          _isRedirecting = false;
          ratingsTotal = 0;
          userRatings = 0;
          commentImg = imgUrl;
        });
      }
    } catch (e) {
      print('Error fetching ratings: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchSpecificData(widget.text);
    fetchWithoutFunct();
    _realTimeFetch();
    fetchDiscountReal();
    print(widget.name);
    _isRedirecting = true;
  }
  @override
  void dispose() {
    _searchController.dispose();
    sub?.cancel();
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
    final data =
        await vouchers.getTheDiscountsAsListOfLikeReal(name, '${widget.name}');
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
          toolbarHeight: 40,
          leading: Builder(
            builder: (BuildContext context) => IconButton(
              icon: const Icon(Icons.menu),
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
                      children: <Widget>[
                        TitleMenu(),
                        HotelSearchMenu(),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: Responsive().infoSizePictureTop(context),
                        child: Container(
                          height: Responsive().infoSizePictureHeight(context),
                          width: Responsive().infoSizePictureWidth(context),
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
                        height:
                            Responsive().scrollableContainerInfoHeight(context),
                        child: Container(
                          padding: const EdgeInsets.only(left: 0, top: 30),
                          width: 500,
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
                                padding: const EdgeInsets.only(right: 0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      child: Text(
                                        text ?? 'No data available',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Responsive().titleFontSize(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
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
                                                      decoration: TextDecoration
                                                          .underline,
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
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: Responsive().aboutPlacement()),
                                      child: Text(
                                        'About',
                                        style: TextStyle(
                                            fontSize:
                                                Responsive().headerFontSize(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      child: Text(
                                        description ?? 'No Description',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize:
                                                Responsive().aboutFontSize()),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        right:
                                            Responsive().amenitiesPlacement(),
                                      ),
                                      child: Text(
                                        'Amenities',
                                        style: TextStyle(
                                            fontSize:
                                                Responsive().headerFontSize(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: imageUrlForAmenities.entries
                                              .map((entry) {
                                        return Row(
                                          children: [
                                            const SizedBox(
                                              width: 35,
                                            ),
                                            Container(
                                              padding: null,
                                              child: Stack(
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
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.12),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        amenities[entry.key] ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList()),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Column(
                                      children: [
                                        Row(children: [
                                          
                                          SizedBox(
                                            width: Responsive()
                                                .sizedBoxRatingWidth(context),
                                          ),
                                          
                                        ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: HotelComments(text: widget.id),
                                        ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(right: 115),
                                      child: const Text(
                                        'Discount Vouchers Available',
                                        style: TextStyle(
                                          fontSize: 20,
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
                                                  child:Container(
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
                                                          BorderRadius.circular(
                                                              12.0),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.black26,
                                                          offset: Offset(0, 4),
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
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8.0),
                                                        Text(
                                                          '${item['hotelName']}',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
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
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  );
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
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: Responsive()
                                                .placeBookingPadding(),
                                            right: Responsive()
                                                .placeBookingPadding()),
                                        width:
                                            Responsive().screenWidth(context),
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
                                                          .bookingPrice(),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '\nEstimated Expenses',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: Responsive()
                                                          .aboutFontSize()))
                                            ])),
                                            Container(
                                              width: Responsive()
                                                  .placeBookingWidth(context),
                                              padding: const EdgeInsets.only(
                                                  left: 50),
                                              child: BlueButtonWithoutFunction(
                                                  text: Text(
                                                    'Place Booking',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: Responsive()
                                                            .aboutFontSize(),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
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
                                                  }),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      )
                    ],
                  )
                ],
              ));
  }
}
