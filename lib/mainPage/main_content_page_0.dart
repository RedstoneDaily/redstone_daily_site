import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';

import '../media_type.dart';
import '../contentPage/typography.dart';
import 'typography.dart';
import 'nav_bar.dart';
import 'nav_button.dart';

class MainContentPage0 extends StatelessWidget {
  const MainContentPage0({super.key});

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

    return SizedBox(
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
          Positioned(top: 0.033 * height, left: 0, right: 0, child: SizedBox(
              // height: 0.044 * height,
              child: NavBar(style: MainPageTypography(height: height).zhTextStyle5.copyWith(color: Colors.white)))),
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
        ]));
  }

  // 将主体文字作为一个整体渲染（这实际上也是可画自动生成的页面所采取的响应式策略）
  Widget mainTexts(BuildContext context, double pageHeight) {
    var width = 1 * pageHeight;
    var height = 0.425 * pageHeight;
    var textStyle = MainPageTypography(height: 0.8 * height);
    return SizedBox(
        width: width,
        height: height,
        child: Stack(fit: StackFit.expand, children: [
          // 红石
          Positioned(
              top: 0.02 * height,
              left: 0.032 * height,
              child: Text(
                "红石",
                style: textStyle.redZhTextStyle1.copyWith(color: RDColors.glass.onSecondary),
              )),

          // 日报
          Positioned(
            top: 0.32 * height,
            left: 0.64 * height,
            child: Text(
              "日报",
              style: textStyle.whiteZhTextStyle1.copyWith(color: RDColors.glass.onPrimary, fontSize: 0.315 * height),
            ),
          ),

          // 俩斜杠
          Transform.translate(
            offset: Offset(height * 0.35, height * 0.32),
            child: CustomPaint(painter: LinePainter(RDColors.glass.onPrimary, Offset(0, height * 0.3), Offset(height * 0.36, 0), 3)),
          ),
          Transform.translate(
            offset: Offset(height * 0.54, height * 0.21),
            child: CustomPaint(painter: LinePainter(RDColors.glass.onSecondary, Offset(0, height * 0.3), Offset(height * 0.36, 0), 3)),
          ),

          // 日期
          Positioned(top: 0.605 * height, left: 1.176 * height, child: DateTextWidget(textStyle.whiteZhTextStyle2.copyWith(fontSize: 0.1 * height))),

          // 发现,并创造自己的灵感
          Positioned(
              top: 0.82 * height,
              left: 0.02 * height,
              child: Text(
                "/发现,并创造自己的灵感/",
                style: textStyle.whiteZhTextStyle2.copyWith(color: RDColors.glass.onPrimary, fontSize: 0.13 * height, letterSpacing: 3.4),
              )),
        ]));
  }
}
