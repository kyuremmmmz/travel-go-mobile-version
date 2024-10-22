import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // responsiveness // The flutter material package for UI

// PLACES, FOODPLACES, FESTIVALS AND EVENTS SQUARE BUTTON AREA WITH SHADOW BOX

// ignore: must_be_immutable
class PlaceButtonSquare extends StatefulWidget{
  late ImageProvider image; // use Image.asset
  late VoidCallback oppressed;
  late String place;
  PlaceButtonSquare
  ({
    super.key,
    required this.place,
    required this.image,
    required this.oppressed,
  });
  @override
  State<StatefulWidget> createState() => _PlaceButtonSquareState();
}

class _PlaceButtonSquareState extends State<PlaceButtonSquare> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 2, // Spread radius of the shadow
            blurRadius: 5, // Blur radius of the shadow
            offset: const Offset(0, 3), // Shadow position (x, y)
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Material(
          child: Ink.image(
            fit: BoxFit.fill,
            width: 100.w,
            height: 100.h,
            image: widget.image,
            child: InkWell(
              onTap: widget.oppressed,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    width: 100.w, 
                    height: 35.h, 
                    child: Text(
                      widget.place,
                      style: TextStyle(
                        fontSize: 12.sp, 
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis, // Optional: handle overflow
                      maxLines: 2, // Optional: limit the number of lines
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
