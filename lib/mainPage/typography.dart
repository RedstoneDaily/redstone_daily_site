import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/jsonobject/NewsPaper.dart';

class MainPageTypography{

  late TextStyle whiteZhTextStyle1;

  late TextStyle whiteZhTextStyle2;
  late TextStyle zhTextStyle3;
  late TextStyle zhTextStyle4;

  late TextStyle whiteEnTextStyle1;

  late TextStyle whiteEnTextStyle2;
  late TextStyle redZhTextStyle1;
  late TextStyle zhTextStyle1;
  late TextStyle zhTextStyle2;

  MainPageTypography({double height = 0, double scaling = 0}){
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
    zhTextStyle1 = TextStyle(
      fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.4 * height,
      letterSpacing: 5.5,
      height: 1.4,
    );
    zhTextStyle2 = TextStyle(
      fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.18 * height,
      letterSpacing: 3.5,
      height: 1.4,
    );
    zhTextStyle3 = TextStyle(
      fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.205 * height,
      letterSpacing: 5
    );
    zhTextStyle4 = TextStyle(
      fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.11 * height,
    );
  }
}