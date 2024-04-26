import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/jsonobject/NewsPaper.dart';

class ContentPageTypography{

  late TextStyle whiteZhTextStyle1;

  late TextStyle whiteZhTextStyle2;
  late TextStyle whiteZhTextStyle3;
  late TextStyle whiteZhTextStyle4;

  late TextStyle whiteEnTextStyle1;

  late TextStyle whiteEnTextStyle2;
  late TextStyle redZhTextStyle1;
  late TextStyle titleStyle;
  late TextStyle headerDescriptionStyle;
  late TextStyle subHeaderDescriptionStyle;
  late TextStyle descriptionStyle;
  late TextStyle blackZhTextStyle1;
  late TextStyle blackZhTextStyle2;

  ContentPageTypography({double height = 0, double scaling = 0}){
    whiteZhTextStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 0.31 * height,
    );
    whiteZhTextStyle2 = TextStyle(
      color: Colors.white,
      fontSize: 0.35 * height,
    );
    whiteEnTextStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 0.155 * height,
    );
    whiteEnTextStyle2 = TextStyle(
      color: Colors.white,
      fontSize: 0.155 * height,
      letterSpacing: 3,
    );
    redZhTextStyle1 =  TextStyle(
      color: Colors.red,
      fontSize: 0.4 * height,
    );
    headerDescriptionStyle = TextStyle(
      fontFamily: '黑体',
      fontSize: 25 * scaling,
      // letterSpacing: 3,
      color: Colors.black87,
    );
    titleStyle = TextStyle(
      fontFamily: 'Kingsoft_Cloud',
      fontSize: 22 * scaling,
      letterSpacing: 0, //3 * scaling,
      color: Colors.white,
    );
    subHeaderDescriptionStyle = TextStyle(
      fontFamily: '黑体',
      fontSize: 12 * scaling,
      // letterSpacing: 3,
      color: Colors.black87,
    );
    descriptionStyle = TextStyle(
      fontFamily: '黑体',
      fontSize: 12 * scaling,
      // letterSpacing: 3,
      height: 1.4,
      color: Colors.black87,
    );
    blackZhTextStyle1 = TextStyle(
      fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.4 * height,
      // letterSpacing: 3,
      height: 1.4,
      color: Colors.black87,
    );
    blackZhTextStyle2 = TextStyle(
      fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.155 * height,
      // letterSpacing: 3,
      height: 1.4,
      color: Colors.black87,
    );

    whiteZhTextStyle3 = TextStyle(
      color: Colors.white,
      fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.31 * height,
    );
    whiteZhTextStyle4 = TextStyle(
      color: Colors.white,
      fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.11 * height,
    );
  }
}