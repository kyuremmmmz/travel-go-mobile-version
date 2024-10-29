import 'package:TravelGo/Controllers/NetworkImages/flightsBackend.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:TravelGo/Widgets/Screens/App/titleMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Allflights extends StatefulWidget {
  const Allflights({super.key});

  @override
  State<Allflights> createState() => _AllflightsState();
}

class _AllflightsState extends State<Allflights> {
  final flights = Flightsbackend();
  List<Map<String, dynamic>> imgUrl = [];
  bool _isRedirecting = false;
  Future<void> fetchFlights() async {
    final result = await flights.allFlights();
    print(result);
    if (result.isNotEmpty) {
      setState(() {
        imgUrl = result;
        _isRedirecting = false;
      });
    }
  }

  @override
  void initState() {
    fetchFlights();
    _isRedirecting = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isRedirecting
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('All Flights'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Row(children: [
                    Padding(
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 60.w),
                        child: const TitleMenu()),
                  ]),
                  SizedBox(height: 10.h),
                  Center(
                    child: Card(
                      color: const Color.fromARGB(255, 223, 234, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color.fromARGB(255, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                          height: 50.sp,
                          width: 200.sp,
                          child: Center(
                            child: Text(
                              'Choose your Flight',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                  Column(
                      children: imgUrl.map((data) {
                    final textt = data['ticket_type'];
                    final text2 = textt[0].toUpperCase() + textt.substring(1);
                    return Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Card(
                                margin: EdgeInsets.zero,
                                color: const Color.fromARGB(255, 223, 234, 252),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    side: BorderSide(color: Colors.black)),
                                child: Container(
                                  padding: null,
                                  width: 300.sp,
                                  height: 50.sp,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        text2,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'Flexible ticket upgrade available',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.green),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Card(
                                color: const Color.fromARGB(255, 232, 240, 253),
                                margin: EdgeInsets.zero,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    side: BorderSide(color: Colors.black)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 330.sp,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 10.h, left: 10.w),
                                                child: Text(
                                                  'Your Flight to Pangasinan',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.sp),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                SizedBox(width: 10.w),
                                                Column(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(data[
                                                              'airplane_img']),
                                                      radius: 20.sp,
                                                    ),
                                                    Text(
                                                      data['airport'],
                                                      style: TextStyle(
                                                          fontSize: 12.sp),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 10.w),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 12.h),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          data[
                                                                              'departure'],
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12.sp),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                5.w),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      '${data['airplane']} . ${data['date']}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              9.sp),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        12.w),
                                                                Icon(
                                                                  Icons
                                                                      .flight_takeoff,
                                                                  size: 18.sp,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.w),
                                                                Container(
                                                                  width: 50.w,
                                                                  height: 2.h,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        10.w),
                                                                Icon(
                                                                  Icons
                                                                      .flight_land,
                                                                  size: 18.sp,
                                                                ),
                                                              ],
                                                            )),
                                                        SizedBox(width: 10.w),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                                height: 12.h),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  data[
                                                                      'arrival'],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12.sp),
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                              ],
                                                            ),
                                                            Text(
                                                              '${data['place']} . ${data['date_departure']}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      9.sp),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 30.h),
                                            Row(
                                              children: [
                                                SizedBox(width: 10.w),
                                                Column(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(data[
                                                              'airplane_img']),
                                                      radius: 20.sp,
                                                    ),
                                                    Text(
                                                      data['airport'],
                                                      style: TextStyle(
                                                          fontSize: 12.sp),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 10.w),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      data[
                                                                          'return'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12.sp),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  '${data['place']} .${data['return_date']}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          9.sp),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 12.w),
                                                            Icon(
                                                                Icons
                                                                    .flight_takeoff,
                                                                size: 18.sp),
                                                            SizedBox(
                                                                width: 10.w),
                                                            Container(
                                                              width: 50.w,
                                                              height: 2.h,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                                width: 10.w),
                                                            Icon(
                                                                Icons
                                                                    .flight_land,
                                                                size: 18.sp),
                                                          ],
                                                        ),
                                                        SizedBox(width: 10.w),
                                                        Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 12),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  data[
                                                                      'return_arrival'],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12.sp),
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                              ],
                                                            ),
                                                            Text(
                                                              '${data['airplane']} . ${data['date_arrival']}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      9.sp),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 30.h),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10.w),
                                                  Text(
                                                    '${data['price'].toString()} PHP',
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 100.w),
                                                  SizedBox(
                                                      height: 30.sp,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      203,
                                                                      223,
                                                                      240),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                          onPressed: () {
                                                            AppRoutes
                                                                .navigateToBookingArea(
                                                                    id: data[
                                                                        'id'],
                                                                    context);
                                                          },
                                                          child: Text(
                                                            'Select',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    16.sp),
                                                          )))
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20.h)
                                          ],
                                        )),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(height: 20.h) //Spacing below the container
                      ]),
                    );
                  }).toList()),
                ],
              )),
            ));
  }
}
