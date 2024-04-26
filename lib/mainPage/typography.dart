
import 'package:flutter/material.dart';

class MainPageTypography{

  late TextStyle whiteZhTextStyle1;
  late TextStyle whiteZhTextStyle2;
  late TextStyle whiteEnTextStyle1;
  late TextStyle whiteEnTextStyle2;
  late TextStyle redZhTextStyle1;

  late TextStyle zhTextStyle1;
  late TextStyle zhTextStyle2;
  late TextStyle zhTextStyle3;
  late TextStyle zhTextStyle4;
  late TextStyle zhTextStyle5;

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
      // fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.116 * height,
      letterSpacing: 5.5,
      height: 1.4,
    );
    zhTextStyle2 = TextStyle(
      // fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.0522 * height,
      letterSpacing: 3.5,
      height: 1.4,
    );
    zhTextStyle3 = TextStyle(
      // fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.05945 * height,
      letterSpacing: 5
    );
    zhTextStyle4 = TextStyle(
      // fontFamily: 'FontquanXinYiGuanHeiTi',
        fontSize: 0.038 * height,
        letterSpacing: 1
    );
    zhTextStyle5 = TextStyle(
      // fontFamily: 'FontquanXinYiGuanHeiTi',
      fontSize: 0.0215 * height,
      letterSpacing: 1.15
    );
  }
}