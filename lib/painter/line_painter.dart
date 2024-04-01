import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  Color color;
  Offset pointA;
  Offset pointB;
  double width = 1;

  LinePainter(this.color,this.pointA,this.pointB,this.width);

  @override
  void paint(Canvas canvas, Size size) {
    //画背景
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth=this.width
      ..color = this.color;
    canvas.drawLine(this.pointA, this.pointB, paint..strokeCap);
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}