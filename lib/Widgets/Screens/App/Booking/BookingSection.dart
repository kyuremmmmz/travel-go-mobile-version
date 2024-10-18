import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final value = NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.only(top: 35, left: 15),
              width: 330,
              height: 230,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(241,252,255, 100),
                border: Border.all(color: const Color.fromRGBO(176,234,253, 100)) 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.departureDay,
                            style: const TextStyle(
                              fontSize: 19
                            ),
                          ),
                          Text(
                            widget.departureDate,
                            style: const TextStyle(
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
                                color: Color.fromRGBO(68,202,249, 100),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            width: 100,
                            height: 50,
                            color: const Color.fromRGBO(68,202,249, 100),
                            child: Text(
                              'PHP ${value.format(widget.price)}',
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
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.locationName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.checkedInDate,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.blue
                    ),
                  ),
                  Text(
                    widget.locationAddress,
                    style: const TextStyle(
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
                        onTap: widget.oppressed,
                        child: const Text(
                          'BOOK AGAIN',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            )
          ),
          Positioned(
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                color: const Color.fromARGB(255, 225, 242, 250),
                border: Border.all(color: const Color.fromRGBO(176,234,253, 100)) 
              ),
              child: Image.asset("assets/images/icon/plane.png"),
            ),
          ),
        ],
      )
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