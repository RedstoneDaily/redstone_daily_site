import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/mainPage/nav_underlined_text.dart';
import 'package:redstone_daily_site/mainPage/typography.dart';

import '../color_schemes.dart';

class NavItem {
  final String name;
  final String dst;
  final bool isRoute;

  const NavItem(this.name, this.dst, {this.isRoute = true});
}

class NavCategory {
  final String categoryName;
  final List<NavItem> items;

  const NavCategory(this.categoryName, this.items);
}

class MainPageEnd extends StatelessWidget {
  const MainPageEnd({super.key});

  static const List<NavCategory> navData = [
    NavCategory("服务", [
      NavItem("最新日报 / 往期", "/daily"),
      NavItem("最新周报 / 往期 (soon)", "/404"),
      NavItem("最新月刊 / 往期 / bilibili (soon)", "/404"),
      NavItem("最新年刊 / 往期 / bilibili (soon)", "/404"),
      NavItem("搜索内容", "/404"),
    ]),
    NavCategory("交流", [
      NavItem("咨询开发团队 / Github", "/404"),
      NavItem("加入交流群", "/404"),
      NavItem("与开发者交流合作 / Github", "/404"),
    ]),
    NavCategory("开发", [
      NavItem("项目开源", "/404"),
      NavItem("加入开发", "/404"),
      NavItem("开发者团队 / Github", "/404"),
      NavItem("API接口 (soon)", "/404"),
    ]),
    NavCategory("其他", [
      NavItem("随机页面", "/404"),
      NavItem("支持我们", "/404"),
      NavItem("致谢", "/404"),
      NavItem("友情链接", "/404"),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var txtHeight = size.height;
    var textStyles = MainPageTypography(pageHeight: txtHeight);
    var width = size.width;
    var height = size.height;
    return Container(
        width: width,
        height: height,
        color: RDColors.white.background,
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
                  style: textStyles.zh_p.copyWith(fontSize: 0.027 * height, color: RDColors.white.onBackground),
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
                          categoryTextStyle: textStyles.zhNavHeader.copyWith(color: RDColors.white.onBackground),
                          itemTextStyle: textStyles.zh_p.copyWith(color: RDColors.white.onBackground)),
                    ))),

            Positioned(
                left: 0,
                right: 0,
                bottom: 0.015 * height,
                child: Text(
                  "非 MINECRAFT 官方产品服务。未经 MOJANG 或 MICROSOFT 批准，也不与 MOJANG 或 MICROSOFT 关联",
                  textAlign: TextAlign.center,
                  style: textStyles.zh_p.copyWith(color: RDColors.white.onBackground),
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
                    Container(height: 2, color: RDColors.white.primaryContainer),
                    ...e.items.map((e) => Padding(
                        padding: EdgeInsets.only(top: 0.012 * height),
                        child: NavUnderlinedText(
                          text: e.name,
                          dst: e.dst,
                          isRoute: e.isRoute,
                          style: itemTextStyle,
                          textAlign: TextAlign.left,
                          underlineAlign: Alignment.bottomLeft,
                          underlineColor: RDColors.white.primaryContainer,
                        )))
                  ],
                ),
              ))
          .expand((e) => [Padding(padding: EdgeInsets.only(left: 0.04 * height)), e])
          .followedBy([Padding(padding: EdgeInsets.only(left: 0.04 * height))]).toList(),
    );
  }
}
