import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class RowDetails extends StatelessWidget {
  String row1, row2;
  RowDetails({
    super.key,
    required this.row1,
    required this.row2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          row1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10.sp,
          ),
        ),
        Text(
          row2,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10.sp,
            color: Color.fromRGBO(5, 103, 180, 1),
          ),
        ),
      ],
    );
  }
}