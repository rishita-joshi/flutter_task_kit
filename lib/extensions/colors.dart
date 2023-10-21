import 'package:flutter/material.dart';

class ThemeClass {
  static final Color greenColor = Color(0xFF1DD05D);

  static final Color greyColor = Color(0xFF2F4858);
  static final Color whiteColor = Color(0xFFFFFF);
  static final Color skyBlueColor = Color(0xFFcbddec);
  static final Color skyBluelightColor = Color(0xFFF2F7FC);
  static final Color lightRedColor = Color(0xffE64C4C);

  static final String appIcon = "sassets/images/main_logo.png";
  static final String appIconBackground = "assets/images/homepage1-01.jpeg";
  static final String smilyEmoji = "assets/images/Group 34.png";
  static final String sadEmoji = "assets/images/Group 24.png";

// ! styling varibles
  static final titleTextStyleGreen = TextStyle(
      color: ThemeClass.greenColor, fontSize: 24, fontWeight: FontWeight.bold);
  static final titleTextStyleGrey = TextStyle(
      color: ThemeClass.greyColor, fontSize: 24, fontWeight: FontWeight.bold);

  static final subTitleStyleGray = TextStyle(
    color: ThemeClass.greyColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  static final subTitleStyleRed = TextStyle(
    color: ThemeClass.lightRedColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  static final smallSubTitleStyleGray = TextStyle(
    color: ThemeClass.greyColor,
    fontSize: 16,
  );
}
