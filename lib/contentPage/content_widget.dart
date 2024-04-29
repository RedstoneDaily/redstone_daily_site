import 'dart:math';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'typography.dart';

// 此组件的高度由content-list提供的约束控制;  可传入scaling参数使内部的排名三角、标题内容的高度和字体进行缩放
class ContentWidget extends StatefulWidget {
  static const double maxHeightHeader = 280;
  static const double maxHeightSubHeader = 130;
  static const double maxHeightContent = 100;

  String title;
  String description;
  String url;
  String imageUrl;
  int ranking;
  late final NewsType type;
  late final double maxHeight;

  ContentWidget({required this.url, required this.imageUrl, required this.title, this.description = "", this.ranking = -1, super.key}) {
    if (description == "" || description == "-") {
      description = "这个人很懒，什么都没有写~";
    }
    maxHeight = switch (type) {
      NewsType.headline => ContentWidget.maxHeightHeader,
      NewsType.subheadline => ContentWidget.maxHeightSubHeader,
      NewsType.content => ContentWidget.maxHeightContent,
    };
  }

  @override
  State<StatefulWidget> createState() {
    return _ContentWidgetState();
  }
}

enum NewsType {
  headline,
  subheadline,
  content,
}

class _ContentWidgetState extends State<ContentWidget> {
  _ContentWidgetState();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double height = min(widget.maxHeight, constraints.maxHeight);
      double scaling = height / widget.maxHeight;
      var textStyles = ContentPageTypography(height: 1, scaling: scaling);

      TextSpan text1stRanking = TextSpan(
          children: [TextSpan(text: "1", style: TextStyle(fontSize: 60 * scaling)), TextSpan(text: "st", style: TextStyle(fontSize: 40 * scaling))],
          style: textStyles.title);
      TextSpan text2ndRanking = TextSpan(
          children: [TextSpan(text: "2", style: TextStyle(fontSize: 30 * scaling)), TextSpan(text: "nd", style: TextStyle(fontSize: 20 * scaling))],
          style: textStyles.title);
      TextSpan text3rdRanking = TextSpan(
          children: [TextSpan(text: "3", style: TextStyle(fontSize: 30 * scaling)), TextSpan(text: "rd", style: TextStyle(fontSize: 20 * scaling))],
          style: textStyles.title);

      double titleHeight = switch (widget.type) { NewsType.headline => 120, NewsType.subheadline => 60, _ => 30 } * scaling;

      double headerRankingHeight = 100 * scaling;
      double subHeaderRankingHeight = 70 * scaling;

      return SizedBox(
          height: height,
          child: InkWell(
              onTap: () => {launchUrlString(widget.url)},
              child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 封面图部分
                    AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Stack(clipBehavior: Clip.none, alignment: Alignment.topRight, children: [
                          // 封面图
                          Positioned.fill(
                            child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                          ),
                          // 左上角三角
                          CustomPaint(
                            painter: TrapezoidPainter(topStart: 0, topEnd: 1.1, bottomStart: 1, bottomEnd: 1.1, color: RDColors.white.primaryContainer),
                            size: Size.square(titleHeight),
                          ),
                          // 排名三角
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: widget.type != NewsType.content
                                ? CustomPaint(
                                    painter: TrapezoidPainter(topStart: 0, topEnd: 0, bottomStart: 0, bottomEnd: 1, color: RDColors.white.primaryContainer),
                                    size: widget.type == NewsType.headline ? Size.square(headerRankingHeight) : Size.square(subHeaderRankingHeight),
                                  )
                                : Container(), // 当条件不满足时，用一个空Container替代
                          ),
                          // 排名文字
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: RichText(
                                  text: switch (widget.ranking) {
                                1 => text1stRanking,
                                2 => text2ndRanking,
                                3 => text3rdRanking,
                                _ => const TextSpan(text: "")
                              }))
                        ])),

                    // 标题简介
                    Expanded(
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      // 标题
                      SizedBox(
                          height: titleHeight,
                          child: Container(
                              clipBehavior: Clip.none,
                              alignment: Alignment.centerLeft,
                              color: RDColors.white.primaryContainer,
                              child: widget.type == NewsType.headline
                                  // 如果是头条，显示Stack”今日头条“+”Headlines Today"+标题
                                  ? Stack(clipBehavior: Clip.none, children: [
                                      // ”今日头条“
                                      Positioned(
                                          left: -40 * scaling,
                                          top: 5 * scaling,
                                          child: Text("今日头条",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'HuXiaoBo',
                                                fontSize: 42 * scaling,
                                                letterSpacing: 3 * scaling,
                                                color: RDColors.white.onPrimaryContainer,
                                              ))),
                                      // ”Headlines Today“
                                      Positioned(
                                          left: 90 * scaling,
                                          top: 5 * scaling,
                                          child: Text("Headlines Today",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'HuXiaoBo',
                                                fontSize: 24 * scaling,
                                                letterSpacing: 3 * scaling,
                                                color: RDColors.white.onPrimaryContainer,
                                              ))),
                                      // 标题
                                      Positioned(
                                          left: -10 * scaling,
                                          bottom: 12 * scaling,
                                          right: 0,
                                          child: Text(widget.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Kingsoft_Cloud',
                                                fontSize: 27 * scaling,
                                                letterSpacing: 0, //3 * scaling,
                                                color: RDColors.white.onPrimaryContainer,
                                              )))
                                    ])
                                  // 否则普通标题
                                  : Text(
                                      widget.title,
                                      style: textStyles.title,
                                      maxLines: widget.type == NewsType.content ? 1 : 2,
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                      // 简介
                      Expanded(
                          child: Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(top: 3, left: 3),
                              child: Text(
                                widget.description,
                                style: switch (widget.type) {
                                  NewsType.headline => textStyles.headlineDescription,
                                  NewsType.subheadline => textStyles.subheadlineDescription,
                                  NewsType.content => textStyles.description,
                                },
                                maxLines: (4 * scaling).floor(),
                                overflow: TextOverflow.ellipsis,
                              )))
                    ]))
                  ])));
    });
  }
}
