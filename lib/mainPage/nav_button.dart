import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redstone_daily_site/color_schemes.dart';

class NavButton extends StatefulWidget {
  final String text;
  final String route;
  final TextStyle? style;
  final TextAlign textAlign;
  final Alignment underlineAlign;
  final Color underlineColor;

  /// 布局行为：默认将宽高收缩到与内部文本相同；
  /// 不建议使用空格来占空间，可能会引起奇怪的行为；
  /// 若需拓展尺寸请使用SizedBox等容器包围
  const NavButton({
    super.key,
    this.route = "/",
    required this.text,
    this.style,
    this.textAlign = TextAlign.center, // seems makes no effect
    this.underlineAlign = Alignment.bottomCenter,
    required this.underlineColor,
  });

  @override
  State<StatefulWidget> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool hover = false;
  GlobalKey textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      return MouseRegion(
          onEnter: (_) => setState(() => hover = true),
          onExit: (_) => setState(() => hover = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              context.go(widget.route);
            },
            child: Stack(
              fit: StackFit.loose,
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned.fill(
                    child: Align(
                        alignment: widget.underlineAlign,
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            width: hover ? (textKey.currentContext!.findRenderObject() as RenderBox).size.width : 0,
                            height: 1,
                            color: widget.underlineColor))),
                SizedBox(
                  width: constraints.minWidth > 0 ? constraints.minWidth : null,
                  height: constraints.minHeight > 0 ? constraints.minHeight : null,
                  child: Text(key: textKey, widget.text, style: widget.style, textAlign: widget.textAlign, maxLines: 1),
                )
              ],
            ),
          ));
    });
  }
}
