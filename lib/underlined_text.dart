import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnderlinedText extends StatefulWidget {
  final void Function()? onTap;

  final String text;
  final TextStyle? style;

  /// 在整体宽度大于文本宽度时见效
  final TextAlign textAlign;

  final bool isUnderlined;

  final double underlineWidth;

  /// default to style?.fontColor if null
  final Color? underlineColor;

  /// 此选项会影响下划线的划出划入动画
  final Alignment underlineAlign;

  /// 布局行为：默认将宽高收缩到与内部文本相同, 除非受父级限制；
  /// 不建议使用空格来占空间，可能会引起奇怪的行为()
  /// 宽度大于文本长度时，下划线会默认拓展至全部宽度; 高度大于文本和下划线的总高时居中.
  const UnderlinedText({
    super.key,
    required this.onTap,
    required this.text,
    this.style,
    this.textAlign = TextAlign.center,
    this.isUnderlined = false,
    this.underlineWidth = 1.0,
    this.underlineAlign = Alignment.bottomCenter,
    this.underlineColor,
  });

  @override
  State<StatefulWidget> createState() => _UnderlinedTextState();
}

class _UnderlinedTextState extends State<UnderlinedText> {
  bool hover = false;
  GlobalKey innerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
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
                              width: (widget.isUnderlined || hover)
                                  ? max(constraints1.minWidth, (innerKey.currentContext!.findRenderObject() as RenderBox).size.width)
                                  : 0,
                              height: widget.underlineWidth,
                              color: widget.underlineColor ?? widget.style?.color)));
                }),
              ],
            );
          }),
        ));
  }
}
