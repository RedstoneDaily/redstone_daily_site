import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../media_type.dart';
import 'nav_button.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      var height = constraints.maxHeight;
      TextStyle style = TextStyle(
          color: Colors.white,
          // fontStyle: FontStyle.italic,
          // fontFamily: "HuXiaoBo",
          fontSize: 0.5 * height);

      return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("  /", style: style),
              NavButton("/", "日报"),
              Text("/", style: style),
              NavButton("/", "探索"),
              Text("/", style: style),
              NavButton("/", "更多"),
              Text("/", style: style),
              const Spacer(),
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 0.15 * height)),
                  SizedBox(
                    width: height * 10,
                    height: height * 0.7,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: style,
                      decoration: InputDecoration(
                        hintText: "搜索日报内容",
                        hintStyle: style,
                        enabledBorder: const UnderlineInputBorder(
                          // 不是焦点的时候颜色
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          // 焦点集中的时候颜色
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              Text("/", style: style),
              NavButton("/", "赞助"),
              Text("/", style: style),
              NavButton("/", "源码"),
              Text("/", style: style),
              NavButton("/", "贡献"),
              Text("/  ", style: style),
            ],
          );
    });
  }
}
