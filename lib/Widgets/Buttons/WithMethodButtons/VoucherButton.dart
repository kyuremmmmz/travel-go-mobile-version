import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class VoucherButton extends StatefulWidget {
  late ImageProvider image; // use Image.asset
  late VoidCallback oppressed;
  late String voucherTitle;
  late String description;
  late String expiring;
  VoucherButton({
    super.key,
    required this.voucherTitle,
    required this.description,
    required this.expiring,
    required this.image,
    required this.oppressed,
  });
  @override
  State<StatefulWidget> createState() => _VoucherButtonState();
}

class _VoucherButtonState extends State<VoucherButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.oppressed,
      child: Container(
        // width: 280.w,
        // height: 100.h,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(194, 228, 231, 100),
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 100.sp,
              height: 100.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromARGB(255, 175, 175, 175),
                    width: 0.5.w),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60.sp,
                    height: 60.sp,
                    child: Image(
                      image: widget.image,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 5.w), // Spacing between icon and text
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              width: 230.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.voucherTitle,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 19.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: const Color.fromRGBO(5, 103, 180, 100),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Expiring: ',
                        style: TextStyle(fontSize: 9.sp),
                      ),
                      Text(
                        widget.expiring,
                        style: TextStyle(fontSize: 9.sp),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
