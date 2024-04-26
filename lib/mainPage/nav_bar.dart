import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../media_type.dart';
import 'nav_button.dart';
import 'nav_button2.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      var height = constraints.maxHeight;
      var width = constraints.maxWidth;
      TextStyle style = TextStyle(
          color: Colors.white,
          // fontStyle: FontStyle.italic,
          // fontFamily: "HuXiaoBo",
          fontSize: 0.5 * height);

      return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(left: width * 0.02)),
              Text(" / ", style: style),
              SizedBox(width: height * 3, child: NavButton(route: "/daily", text: "日报", style: style, underlineColor: Colors.white)),
              Text(" / ", style: style),
              SizedBox(width: height * 3, child: NavButton(route: "/404", text: "探索", style: style, underlineColor: Colors.white)),
              Text(" / ", style: style),
              SizedBox(width: height * 3, child: NavButton(route: "/404", text: "更多", style: style, underlineColor: Colors.white)),
              Text(" / ", style: style),
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
              const Spacer(),
              Text(" / ", style: style),
              SizedBox(width: height * 3, child: NavButton(route: "/404", text: "赞助", style: style, underlineColor: Colors.white)),
              Text(" / ", style: style),
              SizedBox(width: height * 3, child: NavButton(route: "/404", text: "源码", style: style, underlineColor: Colors.white)),
              Text(" / ", style: style),
              SizedBox(width: height * 3, child: NavButton(route: "/404", text: "贡献", style: style, underlineColor: Colors.white)),
              Text(" / ", style: style),
              Padding(padding: EdgeInsets.only(left: width * 0.02)),
            ],
          );
    });
  }
}
