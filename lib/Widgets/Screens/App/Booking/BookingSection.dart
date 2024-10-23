import 'package:TravelGo/Controllers/NetworkImages/bookingHistory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgrest/src/types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil for responsive

class BookingSection extends StatefulWidget {
  final String departureDay;
  final String departureDate;
  final String checkedInDate;
  final int price;
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
      padding: null,
      width: 330.w,
      height: 380.h,
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
                        .replaceAll(
                            '-', '-') 
                        .replaceAll('T', ' ')
                        .replaceAll(
                            RegExp(r'\.\d+'), '');
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
                        .replaceAll(
                            RegExp(r'\.\d+'), '');
                    final date = DateTime.parse(cleanedCheckOut);
                    formattedCheckOutDate =
                        DateFormat('dd').format(date);
                  } catch (e) {
                    formattedCheckOutDate = 'Invalid date format: $e';
                  }
                }

                if (checkOut != null) {
                  try {
                    String cleanedCheckOut = checkOut
                        .replaceAll('T', ' ')
                        .replaceAll(
                            RegExp(r'\.\d+'), ''); 
                    final date = DateTime.parse(cleanedCheckOut);

                    final nextDate = date.add(const Duration(days: 0));
                    formattedNexttDate = DateFormat('MMMM yyyy, EEEE')
                        .format(nextDate); 
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
                      final located = snapshot.data!['hotel_located'] ?? 'Unknown location';
                      return SizedBox(
                        height: 280,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 40,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 35, left: 15),
                                width: 330,
                                height: 230,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        241, 252, 255, 100),
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            176, 234, 253, 100))),
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
                                              style: const TextStyle(fontSize: 19),
                                            ),
                                            Text(
                                              formattedNexttDate,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.blue,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ClipPath(
                                              clipper: LeftPointClipper(),
                                              child: Container(
                                                width: 30,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      68, 202, 249, 100),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 50,
                                              color: const Color.fromRGBO(
                                                  68, 202, 249, 100),
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
                                    const SizedBox(height: 30),
                                    Text(
                                      '${item['hotel']}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      formattedCheckInDate,
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.blue),
                                    ),
                                    Text(
                                      '$located',
                                      style: const TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            print('hello');
                                          },
                                          child: const Text(
                                            'BOOK AGAIN',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 125,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color.fromARGB(
                                        255, 225, 242, 250),
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            176, 234, 253, 100
                                            )
                                          )
                                        ),
                                child: Image.asset("assets/images/icon/plane.png"),
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
