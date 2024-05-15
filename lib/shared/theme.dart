import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme {
  static Color appBarColor = Color.fromRGBO(38, 38, 38, 1);
  static Color blackColor = Color.fromRGBO(30, 30, 30, 1);
  static Color loadingColor = Color.fromRGBO(88, 88, 88, 1).withOpacity(0.4);

  static Color shadowColor = Color(0xffa4a4a4);
  static Color mainColor = Color.fromRGBO(38, 38, 38, 1);
  static Color blueColor = Color.fromRGBO(111, 67, 192, 1);
  // rgb(111, 67, 192)
  static Color greyColor = Color(0xfff1f1f1);
  static Color borderColor = Color(0xffebebeb);
  static Color darkGreyColor = Color(0xffababab);
  static Color textBlackColor = Color(0xffeeeeee);
  static Color iconColor = Color(0xffeeeeee);
  static Color errorColor = Color.fromARGB(255, 218, 0, 0);
  static Color greenColor = Color.fromARGB(255, 62, 186, 56);

  static EdgeInsets margin = EdgeInsets.all(12);
  static EdgeInsets padding = EdgeInsets.all(8);
  static BorderRadius buttonsRadius = BorderRadius.circular(5);

  static getTextStyle1(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle}) {
    return TextStyle(
      fontFamily: 'Cairo',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontVariations: const [
        FontVariation('ital', 0),
        FontVariation('wght', 100),
        FontVariation('ital', 0),
        FontVariation('wght', 200),
        FontVariation('ital', 0),
        FontVariation('wght', 300),
        FontVariation('ital', 0),
        FontVariation('wght', 400),
        FontVariation('ital', 0),
        FontVariation('wght', 500),
        FontVariation('ital', 0),
        FontVariation('wght', 600),
        FontVariation('ital', 0),
        FontVariation('wght', 700),
        FontVariation('ital', 0),
        FontVariation('wght', 800),
        FontVariation('ital', 0),
        FontVariation('wght', 900),
        FontVariation('ital', 1),
        FontVariation('wght', 100),
        FontVariation('ital', 1),
        FontVariation('wght', 200),
        FontVariation('ital', 1),
        FontVariation('wght', 300),
        FontVariation('ital', 1),
        FontVariation('wght', 400),
        FontVariation('ital', 1),
        FontVariation('wght', 500),
        FontVariation('ital', 1),
        FontVariation('wght', 600),
        FontVariation('ital', 1),
        FontVariation('wght', 700),
        FontVariation('ital', 1),
        FontVariation('wght', 800),
        FontVariation('ital', 1),
        FontVariation('wght', 900)
      ],
    );
  }
}
