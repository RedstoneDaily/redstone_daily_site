import 'dart:ui';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:redstone_daily_site/color_schemes.dart';
import '../mainPage/nav_bar.dart';
import '../mainPage/typography.dart';

class Status404Page extends StatelessWidget {
  const Status404Page({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;

    return Material(
      // 添加Material外观，以获得标准的Material风格
      elevation: 4, // 设置阴影
      borderRadius: BorderRadius.circular(8), // 设置边框圆角
      child: Theme(
        data: ThemeData(
          fontFamily: "FontquanXinYiGuanHeiTi",
          colorScheme: RDColors.glass,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.multiply),
                  child: Image.asset(
                    "assets/images/backgrounds/404pagebg.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 0.0982 * height,
                child: NavBar(
                  style: MainPageTypography(pageHeight: height)
                      .zh_p
                      .copyWith(color: RDColors.glass.onBackground),
                ),
              ),
            ),
            Positioned(
              top: 0.15 * height,
              left: 0.1 * height,
              child: _mainTexts(context, height),
            ),
          ],
        ),
      ),
    );
  }

  // Masthead
  Widget _mainTexts(BuildContext context, double pageHeight) {
    var width = 1 * pageHeight;
    var height = 0.625 * pageHeight;
    var textStyle = MainPageTypography(pageHeight: pageHeight);
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0.22 * height,
            left: 0.032 * height,
            child: Text("404", style: textStyle.heroTextRed),
          ),
          Positioned(
            top: 0.48 * height,
            left: 0.02 * height,
            child: Text("恭喜！您要找的页面不存在", style: textStyle.teaser),
          ),
          // 返回主页
          Positioned(
            top: 0.62 * height,
            left: 0.02 * height,
            child: TextButton(
              onPressed: () {
                GoRouter.of(context).go('/');
              },
              child: const Text("返回主页 <<", style: TextStyle(
                fontSize: 16, // Change font size on hover
                color: Colors.white,
              )),
            ),
          ),

        ],
      ),
    );
  }
}
