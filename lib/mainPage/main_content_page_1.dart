import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';

import '../media_type.dart';
import 'nav_bar.dart';
import 'nav_button.dart';
class MainContentPage1 extends StatelessWidget {
  const MainContentPage1({
    super.key,
    required this.height,
    required this.redZhTextStyle1,
    required this.whiteZhTextStyle1,
    required this.whiteZhTextStyle2,
  });

  final double height;
  final TextStyle redZhTextStyle1;
  final TextStyle whiteZhTextStyle1;
  final TextStyle whiteZhTextStyle2;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        Container(height: 10001,color: Colors.black26,),
        Positioned(
            top: height * 0.3,
            left: height * 0.2,
            child: Text(
              "红石",
              style: redZhTextStyle1,
            )),
        CustomPaint(
            painter: LinePainter(Colors.red, Offset(height * 0.5, height * 1.1),
                Offset(height * 1.1, height * 0.4), 2)),

      ]),
    );
  }
}
