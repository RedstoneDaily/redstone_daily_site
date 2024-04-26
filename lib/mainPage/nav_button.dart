import 'package:flutter/material.dart';
import 'package:redstone_daily_site/color_schemes.dart';


class NavButton extends StatefulWidget {
  final String text;
  final String route;
  final TextStyle? style;
  final TextAlign textAlign;
  final Alignment underlineAlign;

  const NavButton({
    super.key,
    this.route = "/",
    required this.text,
    this.style,
    this.textAlign = TextAlign.center,  // seems makes no effect
    this.underlineAlign = Alignment.bottomCenter,
  });

  @override
  State<StatefulWidget> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool hover = false;
  GlobalKey textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      cursor: SystemMouseCursors.click,
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
                      color: RDColorSchemes.white.primaryContainer))),
          Text(key: textKey, widget.text, style: widget.style, textAlign: widget.textAlign),
        ],
      ),
    );
  }
}
