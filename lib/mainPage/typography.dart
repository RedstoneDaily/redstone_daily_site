import 'package:flutter/material.dart';
import 'package:redstone_daily_site/color_schemes.dart';

class MainPageTypography {
  final TextStyle heroTextRed;
  final TextStyle heroTextWhite;
  final TextStyle date;
  final TextStyle teaser;
  final TextStyle whiteEnTextStyle1;
  final TextStyle whiteEnTextStyle2;

  final TextStyle zhHeroText;
  final TextStyle zhTeaser;
  final TextStyle zhButton;
  final TextStyle zhNavHeader;
  final TextStyle zh_p;
  final TextStyle zh_p_small;

  MainPageTypography({required double pageHeight})
      : heroTextRed = TextStyle(
          color: RDColors.glass.onSecondary,
          fontSize: 0.136 * pageHeight,
        ),
        heroTextWhite = TextStyle(
          color: RDColors.glass.onPrimary,
          fontSize: 0.1339 * pageHeight,
        ),
        date = TextStyle(
          color: RDColors.glass.onPrimary,
          fontSize: 0.0425 * pageHeight,
        ),
        teaser = TextStyle(
          color: RDColors.glass.onPrimary,
          fontSize: 0.05525 * pageHeight,
          letterSpacing: 3.4,
        ),
        whiteEnTextStyle1 = TextStyle(
          color: Colors.white,
          fontSize: 0.155 * pageHeight,
        ),
        whiteEnTextStyle2 = TextStyle(
          color: Colors.white,
          fontSize: 0.155 * pageHeight,
          letterSpacing: 3,
        ),
        zhHeroText = TextStyle(
          // fontFamily: 'FontquanXinYiGuanHeiTi',
          fontSize: 0.116 * pageHeight,
          letterSpacing: 5.5,
          height: 1.4,
        ),
        zhTeaser = TextStyle(
          // fontFamily: 'FontquanXinYiGuanHeiTi',
          fontSize: 0.0522 * pageHeight,
          letterSpacing: 3.5,
          height: 1.4,
        ),
        zhButton = TextStyle(
            // fontFamily: 'FontquanXinYiGuanHeiTi',
            fontSize: 0.05945 * pageHeight,
            letterSpacing: 5),
        zhNavHeader = TextStyle(
            // fontFamily: 'FontquanXinYiGuanHeiTi',
            fontSize: 0.038 * pageHeight,
            letterSpacing: 1),
        zh_p = TextStyle(
            // fontFamily: 'FontquanXinYiGuanHeiTi',
            fontSize: 0.0215 * pageHeight,
            letterSpacing: 1.15),
        zh_p_small = TextStyle(
            // fontFamily: 'FontquanXinYiGuanHeiTi',
            fontSize: 0.027 * pageHeight,
            letterSpacing: 1.15);
}
