import 'package:flutter/material.dart';

import '../color_schemes.dart';

class ContentPageTypography{

  late TextStyle mastheadZh1;
  late TextStyle mastheadZh2;
  late TextStyle mastheadEn1;
  late TextStyle mastheadEn2;
  late TextStyle title;
  late TextStyle headlineDescription;
  late TextStyle subheadlineDescription;
  late TextStyle description;

  ContentPageTypography({double height = 0, double scaling = 0}){
    mastheadZh1 = TextStyle(
      color: RDColors.glass.onPrimary,
      fontSize: 0.31 * height,
    );
    mastheadZh2 = TextStyle(
      color: RDColors.glass.onPrimary,
      fontSize: 0.35 * height,
    );
    mastheadEn1 = TextStyle(
      color: RDColors.glass.onPrimary,
      fontSize: 0.155 * height,
    );
    mastheadEn2 = TextStyle(
      color: RDColors.glass.onPrimary,
      fontSize: 0.155 * height,
      letterSpacing: 3,
    );
    title = TextStyle(
      fontFamily: 'Kingsoft_Cloud',
      fontSize: 22 * scaling,
      letterSpacing: 0, //3 * scaling,
      color: RDColors.white.onPrimaryContainer,
    );
    headlineDescription = TextStyle(
      fontFamily: '黑体',
      fontSize: 25 * scaling,
      // letterSpacing: 3,
      color: RDColors.white.onPrimary,
    );
    subheadlineDescription = TextStyle(
      fontFamily: '黑体',
      fontSize: 12 * scaling,
      // letterSpacing: 3,
      color: RDColors.white.onPrimary,
    );
    description = TextStyle(
      fontFamily: '黑体',
      fontSize: 12 * scaling,
      // letterSpacing: 3,
      height: 1.4,
      color: RDColors.white.onPrimary,
    );
  }
}