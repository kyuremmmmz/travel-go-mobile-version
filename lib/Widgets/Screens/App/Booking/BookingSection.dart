import 'package:TravelGo/Controllers/NetworkImages/bookingHistory.dart';
import 'package:flutter/material.dart';

class BookingSection extends StatefulWidget {
  const BookingSection({super.key});

  @override
  State<BookingSection> createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  String? price;
  String? date;
  String? checkIn;
  String? checkOut;
  String? roomType;
  String? hotels;
  BookinghistoryBackend bookings = BookinghistoryBackend();
  List<Map<String, dynamic>> list = [];

  Future<void> getTheBooking() async {
    final response = await bookings.getBookingHistory();
    setState(() {
      list = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getTheBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 330,
        height: 280,
        child: Stack(
            alignment: Alignment.center,
            children: list.map((items) {
              if (list.isEmpty) {
                return const Center(
                  child: Text('No Booking History'),
                );
              } else {
                return Stack(
                  children: [
                    Positioned(
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.only(top: 35, left: 15),
                          width: 330,
                          height: 230,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(241, 252, 255, 100),
                              border: Border.all(
                                  color: const Color.fromRGBO(
                                      176, 234, 253, 100))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '13th',
                                        style: TextStyle(fontSize: 19),
                                      ),
                                      Text(
                                        'October, 2024. Wednesday',
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
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 50,
                                        color: const Color.fromRGBO(
                                            68, 202, 249, 100),
                                        child: Text(
                                          'PHP 999,000',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
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
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                '${items['hotel']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'October 12, 2024, 9:00 AM',
                                style:
                                    TextStyle(fontSize: 11, color: Colors.blue),
                              ),
                              Text(
                                'Calasiao, Pangasinan, Philippines',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        print('hello');
                                      },
                                      child: Text(
                                        'BOOK AGAIN',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                      top: 0,
                      left: 125,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 225, 242, 250),
                            border: Border.all(
                                color: Color.fromRGBO(176, 234, 253, 100))),
                        child: Image.asset("assets/images/icon/plane.png"),
                      ),
                    ),
                  ],
                );
              }
            }).toList()));
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
