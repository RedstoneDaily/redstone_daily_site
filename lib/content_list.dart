import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/content_item.dart';
import 'package:redstone_daily_site/contentwidget.dart';
import 'package:redstone_daily_site/jsonobject/NewsPaper.dart';

class ContentList extends StatelessWidget {

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
        return buildWithNewsPaper(
            newsPaperFromJson(snapshot.data!));
      }
    }


    return FutureBuilder(future: fetchJson(context), builder: builder,);
  }

  Widget buildWithNewsPaper(NewsPaper paper) {
    List<ContentWidget> items = [];
    for (var content in paper.content) {
        var item = ContentWidget(content.coverUrl,content.title, content.description);
        items.add(item);
    }
    var anotherList =<ContentWidget>[];
    anotherList.addAll(items);
    anotherList.removeRange(0, 2);

    return Container(width: 800,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 300,
            height: 100,
            child: items[0],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [items[1],items[2]],
          ),
          Wrap(
            children: [...anotherList],
          )

        ],
      )
    );
  }

}