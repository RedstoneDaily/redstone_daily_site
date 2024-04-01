
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../media_type.dart';
import 'my_nav_button.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height1 = 174;
    var height2 = height1 *
        MediaType.large.width /
        MediaType.medium.width; // sbDart 这个地方不能const
    var height = switch (getMediaType(context)) {
      MediaType.small => size.width / MediaType.medium.width * height1,
      MediaType.medium => size.width / MediaType.medium.width * height1,
      MediaType.large => height2,
    };
    TextStyle style = new TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 0.05*height);

    return Row(
      children: [
        Text("  /",style: style,),
        MyNavButton("/", "日报"),
        Text("/",style: style,),
        MyNavButton("/", "探索"),
        Text("/",style: style,),
        MyNavButton("/", "更多"),
        Text("/",style: style,),
        Spacer(),
        Container(
          width: height*1.2,
          height: height*0.2,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "搜索日报内容",
              hintStyle: style,
              enabledBorder: new UnderlineInputBorder(
                // 不是焦点的时候颜色
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: new UnderlineInputBorder(
                // 焦点集中的时候颜色
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        Spacer(),
        Text("/",style: style,),
        MyNavButton("/", "赞助"),
        Text("/",style: style,),
        MyNavButton("/", "源码"),
        Text("/",style: style,),
        MyNavButton("/", "贡献"),
        Text("/  ",style: style,),
      ],
    );
  }
}
