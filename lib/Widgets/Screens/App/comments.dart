import 'dart:async';
import 'package:TravelGo/Controllers/NetworkImages/imageFromSupabaseApi.dart';
import 'package:TravelGo/Controllers/Profiles/ProfileController.dart';
import 'package:TravelGo/Controllers/Ratings/ratingsBackend.dart';
import 'package:TravelGo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Comments extends StatefulWidget {
  final int text;

  const Comments({super.key, required this.text});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final _searchController = TextEditingController();
  final String beachIcon = "assets/images/icon/beach.png";
  final String foodIcon = "assets/images/icon/food_place.png";
  final String hotelIcon = "assets/images/icon/hotel.png";
  final String festivalIcon = "assets/images/icon/food.png";
  final String hundredIsland = "assets/images/places/HundredIsland.jpeg";
  String? email;
  String? userEmail;
  String? description;
  String? text;
  String? img;
  String? imgUrl;
  String? hasCar;
  String? imageUrl;
  String? comments;
  String? hasMotor;
  String? located;
  var id;
  String? availability;
  String? price;
  final data = Data();
  late Usersss users = Usersss();
  final supabase = Supabase.instance.client;
  bool _isRedirecting = false;
  final _commentController = TextEditingController();
  late RatingsAndComments rating = RatingsAndComments();
  int totalRatings = 0;
  List<Map<String, dynamic>> list = [];
  double ratingsTotal = 0.0;
  int userRatings = 0;
  int ratings = 0;
  late String commentType;
  String? commentImg;
  StreamSubscription? sub;
  final String avatarDefaultIcon = "assets/images/icon/user.png";

  @override
  void initState() {
    super.initState();
    emailFetching();
    fetchSpecificData(widget.text);
    fetchWithoutFunct();
    _realTimeFetch();
    _isRedirecting = true;
  }

  Future<void> stateComments() async {
    final data = await rating.fetchComments(widget.text, 'places');
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

  Future<void> commentInserttion() async {
    rating.postComment(_commentController.text.trim(), ratings,
        commentType = 'places', '$text', widget.text, '$email', '$imgUrl');
  }

  Future<void> fetchSpecificData(int name) async {
    try {
      final dataList = await data.fetchSpecificDataInSingle(name);

      if (dataList == null) {
        setState(() {
          _isRedirecting = false;
          description = "No description available";
        });
      } else {
        setState(() {
          _isRedirecting = false;
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
        _isRedirecting = false;
      });
      print('Error in fetchSpecificData: $e');
    } finally {
      setState(() {
        _isRedirecting = false;
      });
    }
  }

  Future<void> fetchWithoutFunct() async {
    final response = await users.fetchUserWithoutgetter();
    setState(() {
      imgUrl = response[0]['avatar_url'];
    });
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

  Future<void> fetchRatings(List<Map<String, dynamic>> data) async {
    try {
      final data = await rating.fetchComments(widget.text, 'places');
      final totalRatings = await rating.fetchRatingsAsSum();
      final records = data.length;

      if (records > 0) {
        final count = totalRatings / records;
        final validCount = count > 5.0 ? 5.0 : count;

        setState(() {
          list = data;
          ratingsTotal = validCount;
          userRatings = records;
          commentImg = imgUrl;
        });
      } else {
        setState(() {
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
  void dispose() {
    _searchController.dispose();
    _commentController.dispose();
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Container(
              padding: EdgeInsets.only(left: 35.w),
              child: Row(
                children: [
                  Text(
                    '${ratingsTotal.roundToDouble()}/5',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 49, 49, 49),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'OUT OF 5',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 49, 49, 49),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          SizedBox(width: 80.w),
          Row(
              children: List.generate(5, (index) {
            if (index < ratingsTotal) {
              return Icon(
                Icons.star,
                color: Colors.yellow,
                size: 25.sp,
              );
            } else if (index == ratingsTotal && ratingsTotal % 1 != 0) {
              return Icon(
                Icons.star_border,
                color: Colors.yellow,
                size: 25.sp,
              );
            } else {
              return Icon(
                Icons.star_border,
                color: Colors.yellow,
                size: 25.sp,
              );
            }
          }))
        ]),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          child: Container(
            width: 330.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 203, 231, 255),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.w, top: 15.h),
                      child: Text(
                        '$userRatings Comments',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color.fromARGB(255, 44, 44, 44),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20.w, top: 15.h),
                      child: GestureDetector(
                        onTap: () {
                          showAdaptiveDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                      title: Text(
                                        'Rate and review',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 50, 148, 228),
                                      content: SizedBox(
                                          height: 250.sp,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Rating $ratings/5',
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Row(
                                                    children: List.generate(5,
                                                        (index) {
                                                  return IconButton(
                                                    icon: Icon(
                                                        index < ratings
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: Colors.yellow,
                                                        size: 30.sp),
                                                    onPressed: () {
                                                      setState(() {
                                                        ratings = index + 1;
                                                      });
                                                    },
                                                  );
                                                })),
                                                TextField(
                                                    maxLines: 3,
                                                    autocorrect: true,
                                                    controller:
                                                        _commentController,
                                                    style: TextStyle(
                                                        fontSize: 16.sp),
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Write a comment...',
                                                            filled: true,
                                                            fillColor:
                                                                Colors.white,
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .blue)))),
                                                SizedBox(height: 20.h),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                    SizedBox(width: 80.w),
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                        onPressed: () {
                                                          commentInserttion();
                                                          _commentController
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Post',
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )));
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          'Write a comment',
                          style: TextStyle(
                              fontSize: 13.sp,
                              decoration: TextDecoration.underline,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: list.map((place) {
                    final int ratings = place['rating'];
                    final String name = place['full_name'];
                    final String imgUrl = place['avatar_url'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Row(
                            children: [
                              SizedBox(width: 20.w),
                              CircleAvatar(
                                  backgroundImage: imgUrl == "null" ||
                                          imgUrl.contains('null') ||
                                          imgUrl.isEmpty
                                      ? AssetImage(avatarDefaultIcon)
                                      : NetworkImage(imgUrl),
                                  radius: 20.sp),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Text(
                                      name, // Using dynamic name here
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 53, 52, 52),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(5, (index) {
                                        return Icon(
                                            index < ratings
                                                ? Icons.star
                                                : Icons.star_border_outlined,
                                            color: Colors.yellow,
                                            size: 25.sp);
                                      }),
                                      Text(
                                        ' $ratings OUT OF 5',
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                          child:
                              Text('${place['comment']}', // Display the comment
                                  style: TextStyle(fontSize: 14.sp),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5),
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
    );
  }
}
