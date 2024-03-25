import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_network/image_network.dart';
import 'package:redstone_daily_site/trapezoid_painter.dart';
import 'package:url_launcher/url_launcher.dart';


class ContentWidget extends StatefulWidget {
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

  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'HuXiaoBo',
    fontSize: 22,
    letterSpacing: 3,
    color: Colors.white,
  );
  static const TextStyle headerDescriptionStyle = TextStyle(
    fontFamily: '黑体',
    fontSize: 25,
    // letterSpacing: 3,
    color: Colors.black,
  );
  static const TextStyle subHeaderDescriptionStyle = TextStyle(
    fontFamily: '黑体',
    fontSize: 12,
    // letterSpacing: 3,
    color: Colors.black,
  );
  static const TextStyle descriptionStyle = TextStyle(
    fontFamily: '黑体',
    fontSize: 12,
    // letterSpacing: 3,
    color: Colors.black,
  );

  static const TextSpan text1stRanking =
      TextSpan(children: [TextSpan(text: "1", style: TextStyle(fontSize: 60)), TextSpan(text: "st", style: TextStyle(fontSize: 40))], style: titleStyle);
  static const TextSpan text2ndRanking =
      TextSpan(children: [TextSpan(text: "2", style: TextStyle(fontSize: 30)), TextSpan(text: "nd", style: TextStyle(fontSize: 20))], style: titleStyle);
  static const TextSpan text3rdRanking =
      TextSpan(children: [TextSpan(text: "3", style: TextStyle(fontSize: 30)), TextSpan(text: "rd", style: TextStyle(fontSize: 20))], style: titleStyle);

  _ContentWidgetState(this.url, this.imageUrl, this.title, this.msg, this.ranking) {
    type = switch (ranking) {
      1 => newsType.header,
      2 => newsType.subheader,
      3 => newsType.subheader,
      _ => newsType.content,
    };
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      // double height = constraints.maxHeight;
      double heightTitle = switch (type) {
        newsType.header => 120,
        newsType.subheader => 60,
        _ => 30,
      };

      const double heightHeaderRanking = 100;
      const double heightSubHeaderRanking = 70;

      return Row(
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
                    child: Image.network(imageUrl),
                ),
                // 左上角三角
                CustomPaint(
                  painter: TrapezoidPainter(topStart: 0, topEnd: 1.1, bottomStart: 1, bottomEnd: 1.1, color: Theme.of(context).colorScheme.secondary),
                  size: Size.square(heightTitle),
                ),
                // 排名三角
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: type != newsType.content
                      ? CustomPaint(
                          painter: TrapezoidPainter(topStart: 0, topEnd: 0, bottomStart: 0, bottomEnd: 1, color: Theme.of(context).colorScheme.secondary),
                          size: type == newsType.header ? const Size.square(heightHeaderRanking) : const Size.square(heightSubHeaderRanking),
                        )
                      : Container(), // 当条件不满足时，用一个空Container替代
                ),
                // 排名文字
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: RichText(text: switch (ranking) { 1 => text1stRanking, 2 => text2ndRanking, 3 => text3rdRanking, _ => const TextSpan(text: "") }))
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
                    child: InkWell(
                        onTap: () {
                          launch(url);
                        },
                        child: Container(
                            clipBehavior: Clip.none,
                            alignment: Alignment.centerLeft,
                            color: Theme.of(context).colorScheme.secondary,
                            child: type == newsType.header
                                ? Stack(clipBehavior: Clip.none, children: [
                                    Positioned(
                                        left: -40,
                                        top: 5,
                                        child: Text(
                                          "今日头条",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontFamily: 'HuXiaoBo',
                                            fontSize: 42,
                                            letterSpacing: 3,
                                            color: Colors.white,
                                          ),
                                        )),
                                    Positioned(
                                        left: 90,
                                        top: 5,
                                        child: Text(
                                          "Headlines Today",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontFamily: 'HuXiaoBo',
                                            fontSize: 24,
                                            letterSpacing: 3,
                                            color: Colors.white,
                                          ),
                                        )),
                                    Positioned(
                                        left: -10,
                                        bottom: 12,
                                        child: Text(
                                          title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontFamily: 'HuXiaoBo',
                                            fontSize: 27,
                                            letterSpacing: 3,
                                            color: Colors.white,
                                          ),
                                        ))
                                  ])
                                : Text(
                                    title,
                                    style: titleStyle,
                                    maxLines: type == newsType.content ? 1 : 2,
                                    overflow: TextOverflow.ellipsis,
                                  )))),
                // 简介
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      msg,
                      style: switch (type) {
                        newsType.header => headerDescriptionStyle,
                        newsType.subheader => subHeaderDescriptionStyle,
                        newsType.content => descriptionStyle,
                      },
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
