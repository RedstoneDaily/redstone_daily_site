import 'package:flutter/material.dart';

class DragHandle extends StatelessWidget {
  final Axis axis;
  final double strokeWidth;
  const DragHandle({super.key, this.axis = Axis.horizontal, this.strokeWidth = 2});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DragHandlePainter(axis: axis, strokeWidth: strokeWidth, color: Theme.of(context).colorScheme.onSurfaceVariant),
    );
  }
}

class DragHandlePainter extends CustomPainter {
  final Axis axis;
  final double strokeWidth;
  final Color color;

  const DragHandlePainter({this.axis = Axis.horizontal, this.strokeWidth = 2, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    switch (axis) {
      case Axis.vertical:
        canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
        break;
      case Axis.horizontal:
        canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
