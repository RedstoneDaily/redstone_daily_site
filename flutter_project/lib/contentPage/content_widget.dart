import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vector_math/vector_math_64.dart';

import 'typography.dart';

// 此组件的高度由content-list提供的约束控制;  可传入scaling参数使内部的排名三角、标题内容的高度和字体进行缩放
class ContentWidget extends StatefulWidget {
  static const double maxHeightHeader = 280;
  static const double maxHeightSubHeader = 130;
  static const double maxHeightContent = 100;

  final String title;
  late final String description;
  final String url;
  final String imageUrl;
  final int ranking;
  late final NewsType type;
  late final double maxHeight;
  final unescape = HtmlUnescape();

  ContentWidget({required this.url, required this.imageUrl, required this.title, String description = "", this.ranking = -1, super.key}) {
    this.description = (description == "" || description == "-") ? "这个人很懒，什么都没有写~" : unescape.convert(description);
    type = switch (ranking) {
      1 => NewsType.headline,
      2 => NewsType.subheadline,
      3 => NewsType.subheadline,
      _ => NewsType.content,
    };
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

class _ContentWidgetState extends State<ContentWidget> with SingleTickerProviderStateMixin {
  _ContentWidgetState();

  bool isHover = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _colorAnimation = ColorTween(
      begin: RDColors.white.primaryContainer,
      end: RDColors.white.secondaryContainer,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double height = min(widget.maxHeight, constraints.maxHeight);
      double scaling = height / widget.maxHeight;
      var textStyles = ContentPageTypography(height: 1, scaling: scaling);

      TextSpan text1stRanking = TextSpan(children: [
        TextSpan(text: "1", style: textStyles.title.copyWith(fontSize: 60 * scaling)),
        TextSpan(text: "st", style: textStyles.title.copyWith(fontSize: 40 * scaling))
      ], style: textStyles.title);
      TextSpan text2ndRanking = TextSpan(children: [
        TextSpan(text: "2", style: textStyles.title.copyWith(fontSize: 30 * scaling)),
        TextSpan(text: "nd", style: textStyles.title.copyWith(fontSize: 20 * scaling))
      ], style: textStyles.title);
      TextSpan text3rdRanking = TextSpan(children: [
        TextSpan(text: "3", style: textStyles.title.copyWith(fontSize: 30 * scaling)),
        TextSpan(text: "rd", style: textStyles.title.copyWith(fontSize: 20 * scaling))
      ], style: textStyles.title);

      double titleHeight = switch (widget.type) { NewsType.headline => 120, NewsType.subheadline => 60, _ => 30 } * scaling;

      double headerRankingHeight = 100 * scaling;
      double subHeaderRankingHeight = 70 * scaling;

      return SizedBox(
          height: height,
          child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) {
                // _controller.reset();
                _controller.forward();
                setState(() => isHover = true);
              },
              onExit: (_) {
                // _controller.stop();
                _controller.reverse();
                setState(() => isHover = false);
              },
              child: GestureDetector(
                  onTap: () => launchUrlString(widget.url),
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget? child) {
                        return Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: RDColors.white.onBackground.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              )
                            ]),
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
                                          painter: TrapezoidPainter(topStart: 0, topEnd: 1.1, bottomStart: 1, bottomEnd: 1.1, color: _colorAnimation.value!),
                                          size: Size.square(titleHeight),
                                        ),
                                        // 排名三角
                                        Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: widget.type != NewsType.content
                                              ? CustomPaint(
                                                  painter: TrapezoidPainter(
                                                      topStart: 0, topEnd: 0, bottomStart: 0, bottomEnd: 1, color: RDColors.white.primaryContainer),
                                                  size:
                                                      widget.type == NewsType.headline ? Size.square(headerRankingHeight) : Size.square(subHeaderRankingHeight),
                                                )
                                              : Container(), // 当条件不满足时，用一个空Container替代
                                        ),
                                        // 排名文字
                                        Positioned(
                                            left: 3 * scaling,
                                            bottom: 3 * scaling,
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
                                            color: _colorAnimation.value!,
                                            child: widget.type == NewsType.headline
                                                // 如果是头条，显示Stack”今日头条“+”Headlines Today"+标题
                                                ? Stack(clipBehavior: Clip.none, children: [
                                                    // ”今日头条“
                                                    Positioned(
                                                        left: -50 * scaling,
                                                        top: -1 * scaling,
                                                        child: Transform(
                                                            transform: Matrix4.identity()..setColumn(1, Vector4(0.05, 1, 0, 0) * 1.1),
                                                            child: Text("今日头条",
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                  fontSize: 42 * scaling,
                                                                  letterSpacing: -2 * scaling,
                                                                  color: RDColors.white.onPrimaryContainer,
                                                                )))),
                                                    // ”Headlines Today“
                                                    Positioned(
                                                        left: 95 * scaling,
                                                        top: 5 * scaling,
                                                        child: Transform(
                                                            transform: Matrix4.identity()..setColumn(1, Vector4(0.05, 1, 0, 0) * 1.1),
                                                            child: Text("Headlines Today",
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                  fontSize: 24 * scaling,
                                                                  letterSpacing: 0 * scaling,
                                                                  color: RDColors.white.onPrimaryContainer,
                                                                )))),
                                                    // 标题
                                                    Positioned(
                                                        left: -0 * scaling,
                                                        bottom: 15 * scaling,
                                                        right: 0,
                                                        child: Text(widget.title,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 24 * scaling,
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
                                            padding: const EdgeInsets.only(top: 2, left: 3),
                                            color: RDColors.white.primary,
                                            child: Text(
                                              widget.description,
                                              style: switch (widget.type) {
                                                NewsType.headline => textStyles.headlineDescription,
                                                NewsType.subheadline => textStyles.subheadlineDescription,
                                                NewsType.content => textStyles.description,
                                              },
                                              maxLines: (3 * scaling).floor(),
                                              overflow: TextOverflow.ellipsis,
                                            )))
                                  ]))
                                ]));
                      }))));
    });
  }
}
