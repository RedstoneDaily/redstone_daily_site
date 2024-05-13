import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';

import 'nav_bar.dart';
import 'typography.dart';

class MainPage0 extends StatelessWidget {
  const MainPage0({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // double height1 = 560;
    // var height2 = height1 * MediaType.large.width / MediaType.medium.width; // sbDart 这个地方不能const
    // var height = switch (getMediaType(context)) {
    //   MediaType.small => size.width / MediaType.medium.width * height1,
    //   MediaType.medium => size.width / MediaType.medium.width * height1,
    //   MediaType.large => height2,
    // };
    double height = size.height;

    return Theme(
        data: ThemeData(colorScheme: RDColors.glass, fontFamily: "FontquanXinYiGuanHeiTi"),
        child: SizedBox(
            width: size.width,
            height: height,
            child: Stack(children: [

              Positioned.fill(
                  child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: ColorFiltered(
                          // lower the brightness
                          colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.multiply),
                          child: Image.asset(
                            "assets/images/backgrounds/Fparrot_CPU.png",
                            fit: BoxFit.cover,
                          )))),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 0.0982 * height,
                  child: NavBar(
                    style: MainPageTypography(pageHeight: height).zh_p.copyWith(color: RDColors.glass.onBackground),
                  ),
                ),
              ),
              Positioned(top: 0.15 * height, left: 0.1 * height, child: mainTexts(context, height)),

              // Debug Reference Image
              // Positioned(
              //     top: 0,
              //     left: 0,
              //     child: Opacity(
              //         opacity: 0.3,
              //         child: Image.asset(
              //           "assets/images/test-ref-mainPage0.png",
              //           width: size.width,
              //           fit: BoxFit.cover,
              //         )))

            ])));
  }

  // Masthead
  Widget mainTexts(BuildContext context, double pageHeight) {
    var width = 1 * pageHeight;
    var height = 0.425 * pageHeight;
    var textStyle = MainPageTypography(pageHeight: pageHeight);
    return SizedBox(
        width: width,
        height: height,
        child: Stack(fit: StackFit.expand, children: [
          // 红石
          Positioned(
            top: 0.02 * height,
            left: 0.032 * height,
            child: Text("红石", style: textStyle.heroTextRed),
          ),

          // 日报
          Positioned(
            top: 0.32 * height,
            left: 0.64 * height,
            child: Text("日报", style: textStyle.heroTextWhite),
          ),

          // 俩斜杠
          Transform.translate(
              offset: Offset(height * 0.35, height * 0.32),
              child: CustomPaint(
                  painter: LinePainter(
                RDColors.glass.onPrimary,
                Offset(0, height * 0.3),
                Offset(height * 0.36, 0),
                3,
              ))),
          Transform.translate(
              offset: Offset(height * 0.54, height * 0.21),
              child: CustomPaint(
                  painter: LinePainter(
                RDColors.glass.onSecondary,
                Offset(0, height * 0.3),
                Offset(height * 0.36, 0),
                3,
              ))),

          // 日期
          Positioned(
            top: 0.605 * height,
            left: 1.176 * height,
            child: DateTextWidget(textStyle.date),
          ),

          // 发现,并创造自己的灵感
          Positioned(
            top: 0.82 * height,
            left: 0.02 * height,
            child: Text("/发现,并创造自己的灵感/", style: textStyle.teaser),
          ),
        ]));
  }
}
