import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/mainPage/nav_button.dart';
import 'package:redstone_daily_site/mainPage/typography.dart';

import '../color_schemes.dart';

class NavItem {
  final String name;
  final String link;

  const NavItem(this.name, this.link);
}

class NavCategory {
  final String categoryName;
  final List<NavItem> items;

  const NavCategory(this.categoryName, this.items);
}

class MainContentPageEnd extends StatelessWidget {
  const MainContentPageEnd({super.key});

  static const List<NavCategory> navData = [
    NavCategory("服务", [
      NavItem("最新日报 / 往期", "/"),
      NavItem("最新周报 / 往期 (soon)", "/about"),
      NavItem("最新月刊 / 往期 / bilibili (soon)", "/contact"),
      NavItem("最新年刊 / 往期 / bilibili (soon)", "/contact"),
      NavItem("搜索内容", "/contact"),
    ]),
    NavCategory("交流", [
      NavItem("咨询开发团队 / Github", "/daily"),
      NavItem("加入交流群", "/daily/about"),
      NavItem("与开发者交流合作 / Github", "/daily/contact"),
    ]),
    NavCategory("开发", [
      NavItem("项目开源", "/about"),
      NavItem("加入开发", "/contact"),
      NavItem("开发者团队 / Github", "/contact"),
      NavItem("API接口 (soon)", "/contact"),
    ]),
    NavCategory("其他", [
      NavItem("随机页面", "/about"),
      NavItem("支持我们", "/contact"),
      NavItem("致谢", "/contact"),
      NavItem("友情链接", "/contact"),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var txtHeight = size.height;
    var textStyles = MainPageTypography(height: txtHeight);
    var width = size.width;
    var height = size.height;
    return Container(
        width: width,
        height: height,
        color: RDColorSchemes.white.background,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                top: height * (-0.681 + 0.195),
                right: width * -0.019,
                child: Transform.rotate(
                  angle: 21 * 3.14 / 180,
                  child: SizedBox.square(
                    dimension: 0.681 * height,
                    child: Image.asset(
                      "assets/images/recovery_compass_07.png",
                      filterQuality: FilterQuality.none,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Align(
              alignment: const FractionalOffset(0.5, 0.11),
              child: SizedBox.square(
                dimension: 0.39 * height,
                child: compoundIcon(),
              ),
            ),
            Align(
                alignment: const FractionalOffset(0.5, 0.52),
                child: Text(
                  "Redstone / Daily",
                  textAlign: TextAlign.center,
                  style: textStyles.zhTextStyle5.copyWith(fontSize: 0.027 * height, color: RDColorSchemes.white.onBackground),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: min(1.778 * height, width),
                    height: 0.375 * height,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.031 * width),
                      child: navList(
                          height: height,
                          categoryTextStyle: textStyles.zhTextStyle4.copyWith(color: RDColorSchemes.white.onBackground),
                          itemTextStyle: textStyles.zhTextStyle5.copyWith(color: RDColorSchemes.white.onBackground)),
                    ))),

            Positioned(
                left: 0,
                right: 0,
                bottom: 0.015 * height,
                child: Text(
                  "非 MINECRAFT 官方产品服务。未经 MOJANG 或 MICROSOFT 批准，也不与 MOJANG 或 MICROSOFT 关联",
                  textAlign: TextAlign.center,
                  style: textStyles.zhTextStyle5.copyWith(color: RDColorSchemes.white.onBackground),
                )),

            // Debug Reference Image
            // Positioned(
            //     top: 0,
            //     left: 0,
            //     child: Opacity(
            //         opacity: 0.3,
            //         child: Image.asset(
            //           "assets/test-ref-images/mainPage/end.png",
            //           width: size.width,
            //           fit: BoxFit.cover,
            //         )))
          ],
        ));
  }

  Widget compoundIcon() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      var width = constraints.maxWidth;
      var height = constraints.maxHeight;
      var minDim = min(width, height);
      return SizedBox.square(
        dimension: minDim,
        child: Stack(
          children: [
            Positioned(
              top: 1 / 23 * minDim,
              left: 0,
              width: 16 / 23 * minDim,
              height: 16 / 23 * minDim,
              child: Image.asset(
                "assets/images/redstone.png",
                fit: BoxFit.cover,
                filterQuality: FilterQuality.none,
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                width: 16 / 23 * minDim,
                height: 16 / 23 * minDim,
                child: Image.asset(
                  "assets/images/clock.png",
                  fit: BoxFit.cover,
                )),
          ],
        ),
      );
    });
  }

  Widget navList({
    required double height,
    required TextStyle categoryTextStyle,
    required TextStyle itemTextStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: navData
          .map((e) => Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.categoryName,
                      style: categoryTextStyle,
                    ),
                    Container(height: 2, color: RDColorSchemes.white.primaryContainer),
                    ...e.items.map((e) => Padding(
                        padding: EdgeInsets.only(top: 0.012 * height),
                        child: NavButton(
                          text: e.name,
                          route: e.link,
                          style: itemTextStyle,
                          textAlign: TextAlign.left,
                          underlineAlign: Alignment.bottomLeft,
                        )))
                  ],
                ),
              ))
          .expand((e) => [Padding(padding: EdgeInsets.only(left: 0.04 * height)), e])
          .followedBy([Padding(padding: EdgeInsets.only(left: 0.04 * height))]).toList(),
    );
  }
}
