// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/Ratings/ratingsBackend.dart';
import 'package:TravelGo/Controllers/SearchController/searchController.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Buttons/DefaultButtons/BlueButton.dart';
import 'package:TravelGo/Widgets/Buttons/WithMethodButtons/BlueIconButton.dart';
import 'package:TravelGo/Widgets/Drawer/drawerMenu.dart';
import 'package:TravelGo/Widgets/Screens/App/exploreNow.dart';
import 'package:TravelGo/Widgets/Screens/App/flights.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InformationScreen extends StatefulWidget {
  final int text;
  final String? name;
  const InformationScreen({
    super.key,
    required this.text,
    this.name,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _searchController = TextEditingController();
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food_place.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String festivalIcon = "assets/images/icon/food.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  final _commentController = TextEditingController();
  String? email;
  String? userEmail;
  String? description;
  String? text;
  String? img;
  String? imgUrl;
  String? hasCar;
  String? imageUrl;
  String? comments;
  int userRatings = 0;
  String? hasMotor;
  double ratingsTotal = 0.0;
  late String commentType;
  String? located;
  var id;
  int totalRatings = 0;
  int ratings = 0;
  String? availability;
  String? price;
  String? commentImg;
  final data = Data();
  List<Map<String, dynamic>> list = [];
  late Usersss users = Usersss();
  late RatingsAndComments rating = RatingsAndComments();
  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchSpecificData(widget.text);
    fetchRatings(widget.text);
    fetchWithoutFunct();
  }

  Future<void> _isRedirecting() async {
    Future.delayed(const Duration(seconds: 7));
  }

  Future<void> fetchSpecificData(int name) async {
    try {
      final dataList = await data.fetchSpecificDataInSingle(name);

      if (dataList == null) {
        setState(() {
          description = "No description available";
        });
      } else {
        setState(() {
          description = dataList['description'];
          text = dataList['place_name'];
          imageUrl = dataList['image'].toString();
          hasCar = dataList['car_availability'].toString();
          hasMotor = dataList['tricycle_availability'].toString();
          located = dataList['locatedIn'];
          price = dataList['price'];
          availability = dataList['availability'];
        });
      }
    } catch (e) {
      setState(() {
        description = "Error fetching data";
      });
      print('Error in fetchSpecificData: $e');
    }
  }

  Future<void> commentInserttion() async {
    rating.postComment(_commentController.text.trim(), ratings,
        commentType = "places", '$text', widget.text, '$email', '$img');
  }

  Future<void> fetchWithoutFunct() async {
    final response = await users.fetchUserWithoutgetter();
    setState(() {
      imgUrl = response[0]['avatar_url'];
    });
  }

  Future<void> stateComments() async {
    final data = await rating.fetchComments(widget.text);
    final records = data.length;
    final count = totalRatings / records;
    setState(() {
      list = data;
      ratingsTotal = count;
      userRatings = records;
    });
  }

  Future<void> fetchRatings(int id) async {
    final data = await rating.fetchComments(widget.text);
    final totalRatings = await rating.fetchRatingsAsSum();
    final img = await users.fetchUser();
    final images = img[0]['full_name'];
    final imgUrl = await users.fetchImageForComments(images);
    final records = data.length;
    final count = totalRatings / records;
    setState(() {
      list = data;
      ratingsTotal = count;
      userRatings = records;
      commentImg = imgUrl;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> emailFetching() async {
    try {
      final PostgrestList useremail = await users.fetchUser();
      if (useremail.isNotEmpty) {
        setState(() {
          email = useremail[0]['full_name'].toString();
          img = useremail[0]['avatar_url'].toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 40.h, // making height reponsive
          leading: Builder(
            builder: (BuildContext context) => IconButton(
              icon: Icon(Icons.menu, size: 24.sp), // reponsive icon size
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: const DrawerMenuWidget(),
        body: FutureBuilder(
            future: _isRedirecting(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                final error = snapshot.error;
                return Text('Error: $error');
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text(
                    'No connection to the server',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Positioned(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'TRAVEL GO',
                            style: TextStyle(
                              fontSize: 30.sp, // reponsive text
                              color: Color(0xFF44CAF9),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0.h, -2.0.h),
                                  blurRadius: 20,
                                  color: Color.fromARGB(128, 117, 116, 116), // Shadow color with opacity
                                ),
                              ],
                            ),
                          ),
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 59.0.w),
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 12.h), // the top padding for image
                            Image.asset(
                             'assets/images/icon/placeholder.png',
                               width: 13.w,
                               height: 13.h,
                                ),
                          SizedBox(height: 30.h), // the bottom padding for image
                                  ],
                                ),
                          SizedBox(width: 5.w), // Space between image and text
                          Column(
                            mainAxisSize: MainAxisSize.min,
                             children: [
                              SizedBox(height: 12.h), // top padding for text
                              Text(
                                "Northwestern part of Luzon Island, Philippines",
                                style: TextStyle(fontSize: 11.sp),
                                  ),
                                SizedBox(height: 20.h), // bottom padding for text 
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 1.h),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.w), // Search bar in POPULAR PLACES SEARCH BAR
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _searchController,
                        decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await data.fetchinSearch(
                              _searchController.text.trim(), context);
                          },
                        icon: const Icon(
                          Icons.search,
                            )),
                        contentPadding:
                          EdgeInsets.symmetric(vertical: 0.w, horizontal: 10.w),
                          hintStyle: const TextStyle(color: Colors.black54),
                          hintText: 'Search Destination',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50.h)),
                            borderSide: BorderSide.none, // Removed the border
                             ),
                              filled: true,
                              fillColor: Color(0XffDEDEDE),
                                ),
                              ),
                            suggestionsCallback: (pattern) async {
                            return await Searchcontroller().fetchSuggestions(pattern);
                             },
                            itemBuilder: (context, dynamic suggestion) {
                            return ListTile(
                              title: Text(suggestion['title'] ?? 'No title'),
                              subtitle: Text(suggestion['address'] ?? 'No address'),
                                );
                              },
                            onSuggestionSelected: (dynamic suggestion) {
                               _searchController.text = suggestion['title'] ?? 'No title';
                                    FocusScope.of(context).unfocus();
                                },
                             ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 160,
                          child: Container(
                            height: 300,
                            width: 500,
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
                          height: 390,
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
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
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
                                                AppRoutes.navigateToTesting(
                                                    context,
                                                    name: '$located',
                                                    id: widget.text);
                                              },
                                              child: Text(located ??
                                                  'I cant locate it'))
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: const Text(
                                          'About',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Text(
                                          description ?? 'No Description',
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 170),
                                        child: const Text(
                                          'Vehicle Availability',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                BlueIconButtonDefault(
                                                  image:
                                                      'assets/images/icon/tricycle.png',
                                                  oppressed: () =>
                                                      print('Hotels clicked'),
                                                ),
                                                const CategoryLabel(
                                                    label: 'Tricycle'),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                BlueIconButtonDefault(
                                                  image:
                                                      'assets/images/icon/motorbike.png',
                                                  oppressed: () => print(
                                                      'Food Place clicked'),
                                                ),
                                                CategoryLabel(
                                                    label: hasMotor == "true"
                                                        ? 'Motorcycle'
                                                        : 'Unavailable'),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                BlueIconButtonDefault(
                                                  image:
                                                      'assets/images/icon/plane.png',
                                                  oppressed: () =>
                                                      print('Beaches clicked'),
                                                ),
                                                const CategoryLabel(
                                                    label: 'Planes'),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                BlueIconButtonDefault(
                                                  image:
                                                      'assets/images/icon/bus.png',
                                                  oppressed: () => print(
                                                      'Festivals clicked'),
                                                ),
                                                CategoryLabel(
                                                    label: hasCar == "true"
                                                        ? "Bus or Van"
                                                        : "No van or bus available"),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          padding:
                                              const EdgeInsets.only(right: 60),
                                          child: RichText(
                                              text: const TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    'Explore Local Highlights: ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    'Nearby Hotels,\nRestaurants, and Events',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 15,
                                                ))
                                          ]))),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            children: [
                                              BlueIconButtonDefault(
                                                image: beachIcon,
                                                oppressed: () =>
                                                    print('Hotels clicked'),
                                              ),
                                              const CategoryLabel(
                                                  label: 'Hotels'),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              BlueIconButtonDefault(
                                                image: foodIcon,
                                                oppressed: () =>
                                                    print('Food Place clicked'),
                                              ),
                                              const CategoryLabel(
                                                  label: 'Food Place'),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              BlueIconButtonDefault(
                                                image: beachIcon,
                                                oppressed: () =>
                                                    print('Beaches clicked'),
                                              ),
                                              const CategoryLabel(
                                                  label: 'Beaches'),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              BlueIconButtonDefault(
                                                image: festivalIcon,
                                                oppressed: () =>
                                                    print('Festivals clicked'),
                                              ),
                                              const CategoryLabel(
                                                  label:
                                                      'Festivals and \nEvents'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(children: [
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 35),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${ratingsTotal.roundToDouble()}/5',
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 49, 49, 49),
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text(
                                                      'OUT OF 5',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 49, 49, 49),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(
                                              width: 80,
                                            ),
                                            Row(
                                                children:
                                                    List.generate(5, (index) {
                                              if (index < ratingsTotal) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 25,
                                                );
                                              } else if (index ==
                                                      ratingsTotal &&
                                                  ratingsTotal % 1 != 0) {
                                                return const Icon(
                                                  Icons.star_border,
                                                  color: Colors.yellow,
                                                  size: 25,
                                                );
                                              } else {
                                                return const Icon(
                                                  Icons.star_border,
                                                  color: Colors.yellow,
                                                  size: 25,
                                                );
                                              }
                                            }))
                                          ]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SingleChildScrollView(
                                            child: Container(
                                              width: 350,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    255, 203, 231, 255),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                top: 15),
                                                        child: Text(
                                                          '$userRatings Comments',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    44,
                                                                    44,
                                                                    44),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 60,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                top: 15),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            showAdaptiveDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                    return AlertDialog(
                                                                        title:
                                                                            const Text(
                                                                          'Rate and review ',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        backgroundColor: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            50,
                                                                            148,
                                                                            228),
                                                                        content:
                                                                            Container(
                                                                          padding:
                                                                              null,
                                                                          width:
                                                                              400,
                                                                          height:
                                                                              250,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Container(
                                                                                padding: const EdgeInsets.only(right: 210),
                                                                                child: Text(
                                                                                  'Rating $ratings/5',
                                                                                  style: const TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                  children: List.generate(5, (index) {
                                                                                return IconButton(
                                                                                  icon: Icon(
                                                                                    index < ratings ? Icons.star : Icons.star_border,
                                                                                    color: Colors.yellow,
                                                                                    size: 30,
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    setState(() {
                                                                                      ratings = index + 1;
                                                                                    });
                                                                                  },
                                                                                );
                                                                              })),
                                                                              Container(
                                                                                padding: null,
                                                                                child: TextField(
                                                                                    maxLines: 3,
                                                                                    autocorrect: true,
                                                                                    controller: _commentController,
                                                                                    decoration: const InputDecoration(
                                                                                        hintText: 'Write a comment',
                                                                                        filled: true,
                                                                                        fillColor: Colors.white,
                                                                                        border: OutlineInputBorder(
                                                                                          borderSide: BorderSide(color: Colors.black),
                                                                                        ),
                                                                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)))),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: const Text(
                                                                                        'Cancel',
                                                                                        style: TextStyle(color: Colors.black),
                                                                                      )),
                                                                                  const SizedBox(
                                                                                    width: 110,
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                                                                      onPressed: () {
                                                                                        commentInserttion();
                                                                                        fetchRatings(widget.text);
                                                                                        _commentController.clear();
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: const Text(
                                                                                        'Post',
                                                                                        style: TextStyle(color: Colors.black),
                                                                                      )),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ));
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Write a comment',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: list.map((place) {
                                                      final int ratings =
                                                          place['rating'];
                                                      final String name =
                                                          place['full_name'];
                                                      final String imgUrl =
                                                          place['avatar_url'];
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 20),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 20),
                                                                CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    imgUrl,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        name, // Using dynamic name here
                                                                        style:
                                                                            const TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              53,
                                                                              52,
                                                                              52),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        ...List.generate(
                                                                            5,
                                                                            (index) {
                                                                          return Icon(
                                                                            index < ratings
                                                                                ? Icons.star
                                                                                : Icons.star_border_outlined,
                                                                            color:
                                                                                Colors.yellow,
                                                                            size:
                                                                                25,
                                                                          );
                                                                        }),
                                                                        Text(
                                                                          ' $ratings OUT OF 5',
                                                                          style:
                                                                              const TextStyle(fontSize: 12),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        20),
                                                            child: Text(
                                                              '${place['comment']}', // Display the comment
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 5,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }).toList(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    'PHP ${price.toString()} - 6,000',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const TextSpan(
                                                text: '\nEstimated Expenses',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 13))
                                          ])),
                                          Container(
                                            width: 180,
                                            padding:
                                                const EdgeInsets.only(left: 50),
                                            child: BlueButtonWithoutFunction(
                                                text: const Text(
                                                  'See Tickets',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                oppressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Flight()));
                                                }),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
            }));
  }
}