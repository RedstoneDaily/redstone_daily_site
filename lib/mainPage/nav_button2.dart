import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../media_type.dart';

class NavButton2 extends StatefulWidget {
  String text;
  String route = "/";

  NavButton2(this.route, this.text);

  @override
  State<StatefulWidget> createState() {
    return _NavButton2State(route, text);
  }
}

class _NavButton2State extends State<NavButton2> {
  String text;
  String route;
  bool hover = true;

  _NavButton2State(this.route, this.text);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      var height = constraints.maxHeight;
      TextStyle style = TextStyle(
        color: Colors.white,
        // fontStyle: FontStyle.italic,
        fontSize: 0.5 * height,
        // fontFamily: "HuXiaoBo",
      );
      return SizedBox(
        height: height,
        child: TextButton(
            onPressed: () => {context.go(route)},
            onHover: (b) => {
              setState(() {
                hover = !b;
              })
            },
            child: Container(
                decoration: hover
                    ? null
                    : const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5, //宽度
                        color: Colors.red, //边框颜色
                      ),
                    )),
                child: Text(
                  "    $text    ",
                  style: style,
                ))),
      );
    });
  }
}
