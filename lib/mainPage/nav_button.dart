import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../media_type.dart';

class NavButton extends StatefulWidget {
  String text;
  String route = "/";

  NavButton(this.route, this.text);

  @override
  State<StatefulWidget> createState() {
    return _NavButtonState(route, text);
  }
}

class _NavButtonState extends State<NavButton> {
  String text;
  String route;
  bool hover = true;

  _NavButtonState(this.route, this.text);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      var height = constraints.maxHeight;
      var redZhTextStyle1 = TextStyle(
        color: Colors.red,
        fontSize: 0.5 * height,
      );
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
