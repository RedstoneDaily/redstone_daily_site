import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyTextButton.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("/"),
        MyNavButton("/", "日报"),
        Text("/"),
        MyNavButton("/", "探索"),
        Text("/"),
        MyNavButton("/", "更多"),
        Text("/"),
        Spacer(),
        Container(
          width: 500,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "搜索日报内容",
              enabledBorder: new UnderlineInputBorder(
                // 不是焦点的时候颜色
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: new UnderlineInputBorder(
                // 焦点集中的时候颜色
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        Spacer(),
        Text("/"),
        MyNavButton("/", "赞助"),
        Text("/"),
        MyNavButton("/", "源码"),
        Text("/"),
        MyNavButton("/", "贡献"),
        Text("/"),
      ],
    );
  }
}
