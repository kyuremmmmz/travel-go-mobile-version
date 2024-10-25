import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AccountButton extends StatefulWidget{ // use Image.asset
  late VoidCallback oppressed;
  late String header;
  late String details;
  late String image;
  late Color color;
  AccountButton
  ({
    super.key,
    required this.header,
    required this.details,
    required this.color,
    required this.image,
    required this.oppressed,
  });
  @override
  State<StatefulWidget> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Material(
        child: InkWell(
          onTap: widget.oppressed,
          child: Container(
            height: 120.h,
            width: 290.w,
            color: widget.color,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.header,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.details,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Image(
                        image: AssetImage(widget.image), 
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        )
      ),
    );
  }
}