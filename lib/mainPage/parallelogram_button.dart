
import 'package:flutter/material.dart';

import '../painter/trapezoid_painter.dart';

class ParallelogramButton extends StatelessWidget {
  const ParallelogramButton({
    super.key,
    required this.width,
    required this.height,
    this.cutInFraction = 0.16,
    required this.text,
    required this.textStyle,
    required this.buttonColor,
    required this.onTap,
  });

  final String text;
  final GestureTapCallback onTap;
  final double width;
  final double height;
  final double cutInFraction;
  final Color buttonColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            CustomPaint(
                painter: TrapezoidPainter(
                  color: buttonColor,
                  topStart: cutInFraction,
                  topEnd: 1,
                  bottomStart: 0,
                  bottomEnd: 1 - cutInFraction,
                ),
                size: Size(width, height)),
            Align(
                alignment: const FractionalOffset(0.5, 0.3),
                child: Text(text, style: textStyle))
          ],
        ),
      ),
    );
  }
}
