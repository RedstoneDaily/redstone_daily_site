
import 'package:flutter/material.dart';

import '../painter/trapezoid_painter.dart';
import '../text_styles.dart';

class RectangleButton extends StatelessWidget {
  const RectangleButton({
    super.key,
    required this.width,
    required this.height,
    required this.textStyles,
    required this.text,
    required this.callback
  });

  final String text;
  final GestureTapCallback callback;
  final double width;
  final double height;
  final TextStyles textStyles;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: 0.35 * width,
        height: 0.15 * height,
        child: Stack(
          children: [
            CustomPaint(
                painter: TrapezoidPainter(
                    color: Colors.white,
                    topStart: 0.2,
                    topEnd: 1,
                    bottomStart: 0,
                    bottomEnd: 0.8),
                size: Size(0.35 * width, 0.15 * height)),
            Align(
                child: Text(
                  text,
                  style: textStyles.blackZhTextStyle2,
                ))
          ],
        ),
      ),
    );
  }
}
