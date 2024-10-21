import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive{
  double screenWidth(context){
    return MediaQuery.of(context).size.width;
  }
  double infoSizePictureTop(context) {
    return MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 10) * 8.04;
  }
  double infoSizePictureHeight(context) {
    return MediaQuery.of(context).size.height - 560;
  }
  double infoSizePictureWidth(context) {
    return MediaQuery.of(context).size.width + 91;
  }
  double scrollableContainerInfoHeight(context) {
    return MediaQuery.of(context).size.height - ((MediaQuery.of(context).size.height / 10) * 5.5);
  }
  double sizedBoxRatingWidth(context) {
    return MediaQuery.of(context).size.width - 295;
  }
  double placeBookingWidth(context) {
    return 200.w;
  }
  double accomodationPlacement(){
    return 186.w;
  }
  double highlightsPlacement(){
    return 165.w;
  }
  double festivalTipsPlacement(){
    return 155.w;
  }
  double aboutPlacement(){
    return 270.w;
  }
  double amenitiesPlacement(){
    return 230.w;
  }
  double headerFontSize(){
    return 19.sp;
  }
  double titleFontSize(){
    return 23.sp;
  }
  double clickToOpenFontSize(){
    return 10.sp;
  }
  double aboutFontSize(){
    return 13.sp;
  }
  double bookingPrice(){
    return 19.sp;
  }
  double amenitiesBoxHeight(){
    return 120.sp;
  }
  double amenitiesBoxWidth(){
    return 320.sp;
  }
  double placeBookingPadding(){
    return 5.sp;
  }
}