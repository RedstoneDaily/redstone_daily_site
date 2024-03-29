import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/contentPage/content_widget.dart';
import 'package:redstone_daily_site/jsonobject/NewsPaper.dart';
import 'package:redstone_daily_site/media_type.dart';

double lerp(double a, double b, double t) {
  return a + (b - a) * t;
}

double inverseLerp(double a, double b, double x) {
  return (x - a) / (b - a);
}

class ContentList extends StatelessWidget {
  const ContentList({super.key});

  static const double contentListPaddingMedium = 300;
  static const double contentListPaddingSmall = 10;

  // for large device, it is free
  static const double itemPadding = 20;

  Future<String> fetchJson(BuildContext context) async {
    return DefaultAssetBundle.of(context).loadString("assets/demo.json");
  }

  @override
  Widget build(BuildContext context) {
    builder(BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // 当Future还未完成时，显示加载中的UI
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // 当Future发生错误时，显示错误提示的UI
        return Text('Error: ${snapshot.error}');
      } else {
        // 当Future成功完成时，显示数据
        return buildWithNewsPaper(newsPaperFromJson(snapshot.data!), context);
      }
    }

    return FutureBuilder(
      future: fetchJson(context),
      builder: builder,
    );
  }

  Widget buildWithNewsPaper(NewsPaper paper, BuildContext context) {
    var mediaType = getMediaType(context);
    var size = MediaQuery.of(context).size;
    var itemScaling = min(1.0, size.width / MediaType.medium.width);

    List<ContentWidget> items = [];
    paper.content.asMap().entries.forEach((entry) {
      var index = entry.key;
      var content = entry.value;
      items.add(ContentWidget(
        url: content.url,
        imageUrl: content.coverUrl,
        title: content.title,
        description: content.description,
        ranking: index + 1,
      ));
    });

    var anotherList = <ContentWidget>[];
    anotherList.addAll(items);
    anotherList.removeRange(0, 3);

    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: switch (mediaType) {
            MediaType.small => contentListPaddingSmall,
            MediaType.medium => lerp(contentListPaddingSmall, contentListPaddingMedium, inverseLerp(MediaType.medium.width, MediaType.large.width, size.width)),
            _ => contentListPaddingMedium,
          },
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var largeWidth = MediaType.large.width - contentListPaddingMedium;
            return SizedBox(
              width: mediaType != MediaType.large ? double.infinity : largeWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: EdgeInsets.only(top: 35 * itemScaling)),

                  // 头条
                  SizedBox(
                    height: ContentWidget.maxHeightHeader * itemScaling,
                    child: items[0],
                  ),

                  Padding(padding: EdgeInsets.only(top: 25 * itemScaling)),

                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: mediaType == MediaType.small ? 1 : 2,
                      mainAxisExtent: (mediaType == MediaType.small ? 1.5 : 1) * ContentWidget.maxHeightSubHeader * itemScaling,
                      crossAxisSpacing: itemPadding * itemScaling,
                      mainAxisSpacing: itemPadding * itemScaling,
                    ),
                    children: [items[1], items[2]],
                  ),

                  Padding(padding: EdgeInsets.only(top: itemPadding * itemScaling)),

                  // 其余内容
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: mediaType == MediaType.small ? 1 : 2,
                      mainAxisExtent: (mediaType == MediaType.small ? 1.5 : 1) * ContentWidget.maxHeightContent * itemScaling,
                      crossAxisSpacing: itemPadding * itemScaling,
                      mainAxisSpacing: itemPadding * itemScaling,
                    ),
                    children: [...anotherList],
                  ),

                  const Padding(padding: EdgeInsets.only(top: 30)),
                ],
              ),
            );
          },
        ));
  }
}
