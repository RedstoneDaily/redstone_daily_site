import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/contentPage/content_widget.dart';
import 'package:redstone_daily_site/jsonobject/NewsPaper.dart';
import 'package:redstone_daily_site/media_type.dart';

double lerp(double a, double b, double t) {
  return a + (b - a) * t;
}

double inverseLerp(double a, double b, double x) {
  return (x - a) / (b - a);
}

// 网站内容列表
class ContentList extends StatefulWidget {
  const ContentList({super.key});

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  static const double contentListPaddingMedium = 300;
  static const double contentListPaddingSmall = 20;

  // for large device, it is free
  static const double itemPadding = 20;

  late Future<NewsPaper> _futureBuildItems;

  // 异步获取json字符串
  Future<String> fetchJson(BuildContext context) async {
    return DefaultAssetBundle.of(context).loadString("assets/demo.json");
  }

  @override
  void initState() {
    super.initState();
    // 获取内容信息json，并构建内容组件列表
    _futureBuildItems = fetchJson(context).then((str) => newsPaperFromJson(str));
  }

  @override
  Widget build(BuildContext context) {
    builder(BuildContext context, AsyncSnapshot<NewsPaper> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // 当Future还未完成时，显示加载中的UI
        return SliverFillRemaining(
            child: Container(
              color: RDColors.white.surface,
              child: const Center(child: CircularProgressIndicator()),
            )
        );
      } else if (snapshot.hasError) {
        // 当Future发生错误时，显示错误提示的UI
        return Text('Error: ${snapshot.error}');
      } else {
        // 当Future成功完成时，显示数据
        return buildWithNewsPaper(snapshot.data!, context);
      }
    }

    return FutureBuilder(
      future: _futureBuildItems,
      builder: builder,
    );
  }

  List<ContentWidget> buildItems(NewsPaper paper) {
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
    return items;
  }

  // 根据NewsPaper结构进行页面的构建
  Widget buildWithNewsPaper(NewsPaper paper, BuildContext context) {
    var mediaType = getMediaType(context);
    var size = MediaQuery.of(context).size;
    var itemScaling = min(1.0, size.width / MediaType.medium.width);

    var items = buildItems(paper);

    var ordinaries = <ContentWidget>[];
    ordinaries.addAll(items);
    ordinaries.removeRange(0, 3);

    return Padding(
        // 设置两边平行同步
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
              //区块大小, 如果是大区块的,就是最大宽度,否则铺满页面
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
                  // 副头条(2和3)
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: mediaType == MediaType.small ? 1 : 2,
                      mainAxisExtent: (mediaType == MediaType.small ? 1.5 : 1) * ContentWidget.maxHeightSubHeader * itemScaling,
                      crossAxisSpacing: itemPadding * itemScaling,
                      mainAxisSpacing: itemPadding * itemScaling,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
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
                    physics: const NeverScrollableScrollPhysics(),
                    children: [...ordinaries],
                  ),

                  const Padding(padding: EdgeInsets.only(top: 30)),
                ],
              ),
            );
          },
        ));
  }
}
