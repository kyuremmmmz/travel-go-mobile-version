import 'package:flutter/material.dart';

class Responsive{
  double screenWidth(context){
    return MediaQuery.of(context).size.width;
  }
  double infoSizePictureTop(context) {
    print("Height of pic ${MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 10) * 8.04}"); // 1042.6666666666667 For long screen
    return MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 10) * 8.04;
  }
  double infoSizePictureHeight(context) {
    return MediaQuery.of(context).size.height - 560;
  }
  double infoSizePictureWidth(context) {
    return MediaQuery.of(context).size.width + 91;
  }
  double scrollableContainerInfoHeight(context) {
    /*if (MediaQuery.of(context).size.height - 478 > 380) {
      return MediaQuery.of(context).size.height - 478;
    } // 324.9090909090909 in a short screen // 389.42857142857144 in a longer
    else {
      return MediaQuery.of(context).size.height - 378;
    }*/
    return MediaQuery.of(context).size.height - ((MediaQuery.of(context).size.height / 10) * 5.5);
  }
  double scrollableContainerInfoBottom(context) {
    return MediaQuery.of(context).size.height - 860;
  }
  double sizedBoxRatingWidth(context) {
    return MediaQuery.of(context).size.width - 295;
  }
  double placeBookingWidth(context) {
    return MediaQuery.of(context).size.width - 200;
  }
}