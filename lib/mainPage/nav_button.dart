import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavButton extends StatefulWidget {
  final String text;
  final String route;

  const NavButton({this.route = "/", required this.text, super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavButtonState();
  }
}

class _NavButtonState extends State<NavButton> {
  bool hover = true;

  _NavButtonState();

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
            onPressed: () => {context.go(widget.route)},
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
                  "    ${widget.text}    ",
                  style: style,
                ))),
      );
    });
  }
}
