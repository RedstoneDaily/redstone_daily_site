import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NavUnderlinedText extends StatefulWidget {
  final String text;
  final String dst;
  final bool isRoute;
  final TextStyle? style;
  final TextAlign textAlign;
  final double underlineWidth;
  final Alignment underlineAlign;
  final Color? underlineColor;

  /// 布局行为：默认将宽高收缩到与内部文本相同, 除非受父级限制；
  /// 不建议使用空格来占空间，可能会引起奇怪的行为()
  /// 宽度大于文本长度时，下划线会默认拓展至全部宽度; 高度大于文本和下划线的总高时居中.
  const NavUnderlinedText({
    super.key,
    required this.dst,
    required this.isRoute,
    required this.text,
    this.style,
    this.textAlign = TextAlign.center,
    this.underlineWidth = 1.0,
    this.underlineAlign = Alignment.bottomCenter, // Will affect the underline's growth animation direction
    this.underlineColor, // default to style?.fontColor if null
  });

  const NavUnderlinedText.route({
    super.key,
    required this.dst,
    required this.text,
    this.style,
    this.textAlign = TextAlign.center,
    this.underlineWidth = 1.0,
    this.underlineAlign = Alignment.bottomCenter,
    this.underlineColor,
  }) : isRoute = true;

  const NavUnderlinedText.url({
    super.key,
    required this.dst,
    required this.text,
    this.style,
    this.textAlign = TextAlign.center,
    this.underlineWidth = 1.0,
    this.underlineAlign = Alignment.bottomCenter,
    this.underlineColor,
  }) : isRoute = false;

  @override
  State<StatefulWidget> createState() => _NavUnderlinedTextState();
}

class _NavUnderlinedTextState extends State<NavUnderlinedText> {
  bool hover = false;
  GlobalKey innerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => {widget.isRoute ? context.go(widget.dst) : launchUrlString(widget.dst)},
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints1) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(key: innerKey, widget.text, style: widget.style, textAlign: widget.textAlign, maxLines: 1),
                // Postpone the layout so that it can get the size of the text. Magic.()
                LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints2) {
                  return SizedBox(
                      width: max(constraints1.minWidth, (innerKey.currentContext!.findRenderObject() as RenderBox).size.width),
                      height: widget.underlineWidth,
                      child: Align(
                          alignment: widget.underlineAlign,
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              width: hover ? max(constraints1.minWidth, (innerKey.currentContext!.findRenderObject() as RenderBox).size.width) : 0,
                              height: widget.underlineWidth,
                              color: widget.underlineColor ?? widget.style?.color)));
                }),
              ],
            );
          }),
        ));
  }
}
