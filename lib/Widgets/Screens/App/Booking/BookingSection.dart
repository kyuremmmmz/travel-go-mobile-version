import 'package:TravelGo/Controllers/NetworkImages/bookingHistory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgrest/src/types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil for responsive

class BookingSection extends StatefulWidget {
  final String departureDay;
  final String departureDate;
  final String checkedInDate;
  final double price;
  final String locationName;
  final String locationAddress;
  final VoidCallback oppressed;
  const BookingSection({
    super.key,
    required this.departureDay,
    required this.departureDate,
    required this.checkedInDate,
    required this.price,
    required this.locationName,
    required this.locationAddress,
    required this.oppressed,
  });

  @override
  State<BookingSection> createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  BookinghistoryBackend bookings = BookinghistoryBackend();
  List<Map<String, dynamic>> list = [];
  String? located;

  Future<void> getTheBooking() async {
    final response = await bookings.getBookingHistory();
    setState(() {
      list = response;
    });
  }

  Future<PostgrestMap?> getPlace(String hotel) async {
    try {
      final response = await bookings.getPlace(hotel);
      located = response!['hotel_located'];
      return response;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getTheBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20.0),
      width: 330.w,
      height: 580.h,
      child: list.isEmpty
          ? const Center(
              child: Text('No Booking History'),
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                final price = NumberFormat('#,###');
                final priceFormatted = price.format(item['price']);
                final hotel = item['hotel'];
                String? checkIn = item['checkout'];
                String? checkOut = item['checkin'];
                String formattedCheckInDate = 'No check-in date available';
                String formattedCheckOutDate = 'No check-out date available';
                String formattedNexttDate = 'No nextt date available';
                if (checkIn != null) {
                  try {
                    String cleanedCheckIn = checkIn
                        .replaceAll('-', '-')
                        .replaceAll('T', ' ')
                        .replaceAll(RegExp(r'\.\d+'), '');
                    final date = DateTime.parse(cleanedCheckIn);
                    formattedCheckInDate =
                        DateFormat('MMMM dd, yyyy, h:mm a').format(date);
                  } catch (e) {
                    formattedCheckInDate = 'Invalid date format: $e';
                  }
                }

                if (checkOut != null) {
                  try {
                    String cleanedCheckOut = checkOut
                        .replaceAll('T', ' ')
                        .replaceAll(RegExp(r'\.\d+'), '');
                    final date = DateTime.parse(cleanedCheckOut);
                    formattedCheckOutDate = DateFormat('dd').format(date);
                  } catch (e) {
                    formattedCheckOutDate = 'Invalid date format: $e';
                  }
                }

                if (checkOut != null) {
                  try {
                    String cleanedCheckOut = checkOut
                        .replaceAll('T', ' ')
                        .replaceAll(RegExp(r'\.\d+'), '');
                    final date = DateTime.parse(cleanedCheckOut);

                    final nextDate = date.add(const Duration(days: 0));
                    formattedNexttDate =
                        DateFormat('MMMM yyyy, EEEE').format(nextDate);
                  } catch (e) {
                    formattedCheckOutDate = 'Invalid date format: $e';
                  }
                }

                return FutureBuilder<PostgrestMap?>(
                  future: getPlace(hotel),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final located =
                          snapshot.data!['hotel_located'] ?? 'Unknown location';
                      return SizedBox(
                        height: 280.h,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20.w,
                              child: Container(
                                padding: EdgeInsets.only(top: 35.h, left: 15.h),
                                width: 330.w,
                                height: 250.h,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF1FCFF),
                                    border:
                                        Border.all(color: Color(0xFFE1F2FA))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${formattedCheckOutDate}th',
                                              style: TextStyle(fontSize: 19.sp),
                                            ),
                                            Text(
                                              formattedNexttDate,
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Color(0xFF2196F3),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ClipPath(
                                              clipper: LeftPointClipper(),
                                              child: Container(
                                                width: 28.w,
                                                height: 48.h,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      68, 202, 249, 100),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              //Arrow area
                                              padding:
                                                  EdgeInsets.only(right: 5.w),
                                              alignment: Alignment.center,
                                              width: 98.w,
                                              height: 48.h,
                                              color: Color(0xFF44CAF9),
                                              child: Text(
                                                'PHP $priceFormatted',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 30.h),
                                    Text(
                                      '${item['hotel']}',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      formattedCheckInDate,
                                      style: TextStyle(
                                          fontSize: 11.sp, color: Colors.blue),
                                    ),
                                    Text(
                                      '$located',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            print('hello');
                                          },
                                          child: Container(
                                            // New container for width and height
                                            width:
                                                100.w, // Set responsive width
                                            height:
                                                20.h, // Set responsive height
                                            alignment: Alignment
                                                .center, // Center the text within the container
                                            child: Text(
                                              'BOOK AGAIN',
                                              style: TextStyle(
                                                fontSize: 15
                                                    .sp, // Responsive font size
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0.h,
                              left: 125.h,
                              child: Container(
                                padding: EdgeInsets.all(15.h),
                                height: 75.h,
                                width: 75.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color.fromARGB(
                                        255, 225, 242, 250),
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            176, 234, 253, 100))),
                                child:
                                    Image.asset("assets/images/icon/plane.png"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}

class LeftPointClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 2); // Start at the middle of the left side
    path.lineTo(size.width / 3, 0); // Top corner of the arrow
    path.lineTo(size.width, 0); // Top right corner
    path.lineTo(size.width, size.height); // Bottom right corner
    path.lineTo(size.width / 3, size.height); // Bottom corner of the arrow
    path.close(); // Complete the shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
