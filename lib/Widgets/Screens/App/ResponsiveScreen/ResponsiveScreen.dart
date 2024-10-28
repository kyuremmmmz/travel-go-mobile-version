import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  double screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  double infoSizePictureTop() {
    return 170.h;
  }

  double infoSizePictureHeight() {
    return 200.sp;
  }

  double infoSizePictureWidth() {
    return 500.sp;
  }

  double scrollableContainerInfoTop() {
    return 350.h;
  }

  EdgeInsets containerPaddingTop() {
    return EdgeInsets.only(top: 30.h);
  }

  BorderRadius borderRadiusTop() {
    return BorderRadius.only(
        topLeft: Radius.circular(25.sp), topRight: Radius.circular(25.sp));
  }

  EdgeInsets horizontalPadding() {
    return EdgeInsets.symmetric(horizontal: 30.w);
  }

  double sizedBoxRatingWidth(context) {
    return MediaQuery.of(context).size.width - 295;
  }

  double buttonWidth() {
    return 200.w;
  }

  double highlightsPlacement() {
    return 165.w;
  }

  double festivalTipsPlacement() {
    return 155.w;
  }

  double headerFontSize() {
    return 20.sp;
  }

  double titleFontSize() {
    return 23.sp;
  }

  double clickToOpenFontSize() {
    return 10.sp;
  }

  double aboutFontSize() {
    return 13.sp;
  }

  double amenitiesBoxHeight() {
    return 120.sp;
  }

  double amenitiesBoxWidth() {
    return 320.sp;
  }

  BorderRadius amenitiesBorderRadius() {
    return BorderRadius.all(Radius.circular(15.sp));
  }

  BorderRadius amenitiesTextBorderRadius() {
    return BorderRadius.only(
        bottomLeft: Radius.circular(15.sp),
        bottomRight: Radius.circular(15.sp));
  }

  double placeBookingPadding() {
    return 5.sp;
  }

  double settingSelectionWidth() {
    return 258.sp;
  }

  double settingSelectionHeight() {
    return 155.sp;
  }

  double settingTitleWidth() {
    return 300.sp;
  }

  double settingTitleHeight() {
    return 45.sp;
  }

  double settingProfileRadius() {
    return 40.sp;
  }

  double discountProfileRadius() {
    return 29.sp;
  }
}
