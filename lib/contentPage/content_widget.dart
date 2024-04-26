import 'dart:math';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';
import 'package:url_launcher/url_launcher.dart';

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

  ContentWidget({required this.url, this.imageUrl = "", this.title = "", this.description = "", this.ranking = -1, super.key}) {
    if (description == "" || description == "-") {
      description = "这个人很懒，什么都没有写~";
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _ContentWidgetState(url, imageUrl, title, description, ranking);
  }
}

enum newsType {
  header,
  subheader,
  content,
}

class _ContentWidgetState extends State<ContentWidget> {
  String title;
  String msg;
  int ranking;
  String url;
  String imageUrl;
  late final newsType type;
  late final double maxHeight;

  // late final double minElasticWidth;   // 最小弹性宽度———大于这个宽度标题内容的长度会自动伸长，小于这个宽度则会整体缩放

  _ContentWidgetState(this.url, this.imageUrl, this.title, this.msg, this.ranking) {
    type = switch (ranking) {
      1 => newsType.header,
      2 => newsType.subheader,
      3 => newsType.subheader,
      _ => newsType.content,
    };
    maxHeight = switch (type) {
      newsType.header => ContentWidget.maxHeightHeader,
      newsType.subheader => ContentWidget.maxHeightSubHeader,
      newsType.content => ContentWidget.maxHeightContent,
    };
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double height = min(maxHeight, constraints.maxHeight);
      double scaling = height / maxHeight;
      var textStyles = ContentPageTypography(height: 1,scaling: scaling);


      TextSpan text1stRanking = TextSpan(
          children: [TextSpan(text: "1", style: TextStyle(fontSize: 60 * scaling)), TextSpan(text: "st", style: TextStyle(fontSize: 40 * scaling))],
          style: textStyles.titleStyle);
      TextSpan text2ndRanking = TextSpan(
          children: [TextSpan(text: "2", style: TextStyle(fontSize: 30 * scaling)), TextSpan(text: "nd", style: TextStyle(fontSize: 20 * scaling))],
          style: textStyles.titleStyle);
      TextSpan text3rdRanking = TextSpan(
          children: [TextSpan(text: "3", style: TextStyle(fontSize: 30 * scaling)), TextSpan(text: "rd", style: TextStyle(fontSize: 20 * scaling))],
          style: textStyles.titleStyle);

      double heightTitle = switch (type) {
            newsType.header => 120,
            newsType.subheader => 60,
            _ => 30,
          } *
          scaling;

      double heightHeaderRanking = 100 * scaling;
      double heightSubHeaderRanking = 70 * scaling;

      return SizedBox(
          height: height,
          child: InkWell(
              onTap: () {
                launchUrl(Uri.parse(url));
              },
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 封面图部分
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topRight,
                      children: [
                        // 封面图
                        Positioned.fill(
                          child: Image.network(imageUrl, fit: BoxFit.cover),
                        ),
                        // 左上角三角
                        CustomPaint(
                          painter: TrapezoidPainter(topStart: 0, topEnd: 1.1, bottomStart: 1, bottomEnd: 1.1, color: RDColorSchemes.white.primaryContainer),
                          size: Size.square(heightTitle),
                        ),
                        // 排名三角
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: type != newsType.content
                              ? CustomPaint(
                                  painter:
                                      TrapezoidPainter(topStart: 0, topEnd: 0, bottomStart: 0, bottomEnd: 1, color: RDColorSchemes.white.primaryContainer),
                                  size: type == newsType.header ? Size.square(heightHeaderRanking) : Size.square(heightSubHeaderRanking),
                                )
                              : Container(), // 当条件不满足时，用一个空Container替代
                        ),
                        // 排名文字
                        Positioned(
                            left: 0,
                            bottom: 0,
                            child: RichText(
                                text: switch (ranking) { 1 => text1stRanking, 2 => text2ndRanking, 3 => text3rdRanking, _ => const TextSpan(text: "") }))
                      ],
                    ),
                  ),

                  // 标题简介
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 标题
                        SizedBox(
                            height: heightTitle,
                            child: Container(
                                clipBehavior: Clip.none,
                                alignment: Alignment.centerLeft,
                                color: RDColorSchemes.white.primaryContainer,
                                child: type == newsType.header
                                    // 如果是头条，显示Stack”今日头条“+”Headlines Today"+标题
                                    ? Stack(clipBehavior: Clip.none, children: [
                                        // ”今日头条“
                                        Positioned(
                                            left: -40 * scaling,
                                            top: 5 * scaling,
                                            child: Text(
                                              "今日头条",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'HuXiaoBo',
                                                fontSize: 42 * scaling,
                                                letterSpacing: 3  * scaling,
                                                color: Colors.white,
                                              ),
                                            )),
                                        // ”Headlines Today“
                                        Positioned(
                                            left: 90 * scaling,
                                            top: 5 * scaling,
                                            child: Text(
                                              "Headlines Today",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'HuXiaoBo',
                                                fontSize: 24 * scaling,
                                                letterSpacing: 3 * scaling,
                                                color: Colors.white,
                                              ),
                                            )),
                                        // 标题
                                        Positioned(
                                            left: -10 * scaling,
                                            bottom: 12 * scaling,
                                            right: 0,
                                            child: Text(
                                              title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Kingsoft_Cloud',
                                                fontSize: 27 * scaling,
                                                letterSpacing: 0, //3 * scaling,
                                                color: Colors.white,
                                              ),
                                            ))
                                      ])
                                    // 否则普通标题
                                    : Text(
                                        title,
                                        style: textStyles.titleStyle,
                                        maxLines: type == newsType.content ? 1 : 2,
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                        // 简介
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 3, left: 3),
                            child: Text(
                              msg,
                              style: switch (type) {
                                newsType.header => textStyles.headerDescriptionStyle,
                                newsType.subheader => textStyles.subHeaderDescriptionStyle,
                                newsType.content => textStyles.descriptionStyle,
                              },
                              maxLines: (4 * scaling).floor(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )));
    });
  }
}
