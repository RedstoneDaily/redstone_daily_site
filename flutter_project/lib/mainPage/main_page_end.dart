import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redstone_daily_site/mainPage/nav_underlined_text.dart';
import 'package:redstone_daily_site/mainPage/typography.dart';
import 'package:redstone_daily_site/underlined_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../color_schemes.dart';
import '../selector_dialog.dart';

///
/// Data Structs
///
/// (sbDart怎么又双叒叕const不了

class NavItemFragment {
  final String name;
  final void Function(BuildContext)? onTap;

  const NavItemFragment(this.name, {this.onTap});

  NavItemFragment.link(this.name, String dst, {bool isRoute = true})
      : onTap = ((BuildContext context) {
          if (isRoute) {
            context.go(dst);
          } else {
            launchUrl(Uri.parse(dst));
          }
        });
}

class NavItem {
  final List<NavItemFragment> fragments;

  NavItem(String name, String dst, {bool isRoute = true}) : fragments = [NavItemFragment.link(name, dst, isRoute: isRoute)];

  const NavItem.multiFrags(this.fragments);
}

class NavCategory {
  final String categoryName;
  final List<NavItem> items;

  const NavCategory(this.categoryName, this.items);
}

class MainPageEnd extends StatelessWidget {
  MainPageEnd({super.key});

  final List<NavCategory> navData = [
    NavCategory("服务", [
      NavItem.multiFrags([
        NavItemFragment.link("最新日报", "/daily"),
        NavItemFragment("往期", onTap: (context) => showSelectorDialog(context: context, colors: RDColors.glass)),
      ]),
      NavItem.multiFrags([
        NavItemFragment.link("最新周报", "/coming-soon"),
        NavItemFragment.link("往期 (soon)", "/coming-soon"),
      ]),
      NavItem.multiFrags([
        NavItemFragment.link("最新月刊", "/coming-soon"),
        NavItemFragment.link("往期", "/coming-soon"),
        NavItemFragment.link("bilibili (soon)", "/coming-soon"),
      ]),
      NavItem.multiFrags([
        NavItemFragment.link("最新年刊", "/coming-soon"),
        NavItemFragment.link("往期", "/coming-soon"),
        NavItemFragment.link("bilibili (soon)", "/coming-soon"),
      ]),
      NavItem("搜索内容", "/coming-soon"),
    ]),
    NavCategory("交流", [
      NavItem("咨询开发团队 (Github)", "https://github.com/RedstoneDaily/redstone_daily/issues", isRoute: false),
      NavItem("加入交流群", "https://qm.qq.com/q/AAUEeKKrok", isRoute: false),
      NavItem("与开发者交流合作", "/articles/contribution.md"),
    ]),
    NavCategory("开发", [
      NavItem("项目开源", "https://github.com/RedstoneDaily/redstone_daily", isRoute: false),
      NavItem("加入开发", "/articles/join-us.md"),
      NavItem("开发者团队 (Github)", "https://github.com/RedstoneDaily", isRoute: false),
      NavItem("API接口 (soon)", "/coming-soon"),
    ]),
    NavCategory("其他", [
      NavItem("随机页面", "/random"),
      NavItem("支持我们", "https://afdian.com/a/crebet", isRoute: false),
      NavItem("致谢", "/articles/credits.md"),
      NavItem("友情链接", "/articles/links.md"),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var txtHeight = size.height;
    var textStyles = MainPageTypography(pageHeight: txtHeight);
    var width = size.width;
    var height = size.height;
    return Material(
        child: Container(
            width: width,
            height: height,
            color: RDColors.white.background,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 上一页的compass
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

                // 复合icon
                Align(
                  alignment: const FractionalOffset(0.5, 0.11),
                  child: SizedBox.square(
                    dimension: 0.39 * height,
                    child: compoundIcon(),
                  ),
                ),

                // "Redstone / Daily"
                Align(
                    alignment: const FractionalOffset(0.5, 0.52),
                    child: Text(
                      "Redstone / Daily",
                      textAlign: TextAlign.center,
                      style: textStyles.zh_p.copyWith(fontSize: 0.027 * height, color: RDColors.white.onBackground),
                    )),

                // 链接/导航
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: min(1.778 * height, width),
                        height: 0.375 * height,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.031 * width),
                          child: navList(
                              context: context,
                              height: height,
                              categoryTextStyle: textStyles.zhNavHeader.copyWith(color: RDColors.white.onBackground),
                              itemTextStyle: textStyles.zh_p.copyWith(color: RDColors.white.onBackground)),
                        ))),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0.015 * height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "非 MINECRAFT 官方产品服务。未经 MOJANG 或 MICROSOFT 批准，也不与 MOJANG 或 MICROSOFT 关联",
                        textAlign: TextAlign.center,
                        style: textStyles.zh_p.copyWith(color: RDColors.white.onBackground),
                      ),
                      Padding(padding: EdgeInsets.only(top: 0.01 * height)),
                      NavUnderlinedText.url(
                          dst: "https://beian.miit.gov.cn/",
                          text: "ICP备案号：闽ICP备2024058720号-2",
                          style: textStyles.zh_p.copyWith(color: RDColors.white.onBackground),
                          textAlign: TextAlign.center,
                          underlineColor: RDColors.white.primaryContainer,
                          underlineAlign: Alignment.bottomCenter
                      ),
                    ],
                  ),
                ),

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
            )));
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
    required BuildContext context,
    required double height,
    required TextStyle categoryTextStyle,
    required TextStyle itemTextStyle,
  }) {
    Widget padding = Padding(padding: EdgeInsets.only(left: 0.04 * height));
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
                        child:
                            // NavUnderlinedText(
                            //   text: e.name,
                            //   dst: e.dst,
                            //   isRoute: e.isRoute,
                            //   style: itemTextStyle,
                            //   textAlign: TextAlign.left,
                            //   underlineAlign: Alignment.bottomLeft,
                            //   underlineColor: RDColors.white.primaryContainer,
                            // )
                            Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...e.fragments
                                .map((e) => UnderlinedText(
                                      onTap: () => e.onTap?.call(context),
                                      text: e.name,
                                      style: itemTextStyle,
                                      textAlign: TextAlign.left,
                                      underlineAlign: Alignment.bottomLeft,
                                      underlineColor: RDColors.white.primaryContainer,
                                    ))
                                .expand((fragWidget) => [Text(" / ", style: itemTextStyle), fragWidget])
                                .skip(1)
                          ],
                        )))
                  ],
                ),
              ))
          .expand((e) => [padding, e])
          .followedBy([padding]).toList(),
    );
  }
}
