import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';

import '../media_type.dart';
import 'nav_bar.dart';
import 'nav_button.dart';
class MainContentPage0 extends StatelessWidget {
  const MainContentPage0({
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
    return Stack(children: [
      Image.asset("assets/images/main_1.png"),
      NavBar(),
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
      CustomPaint(
          painter: LinePainter(
              Colors.white,
              Offset(height * 0.55, height * 1.15),
              Offset(height * 1.15, height * 0.45),
              2)),
      Positioned(
          top: height * 0.8,
          left: height * 1.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "日报",
                style: whiteZhTextStyle1,
              ),
              DateTextWidget(whiteZhTextStyle2),
            ],
          )),
      Positioned(
          top: height * 1.5,
          left: height * 0.2,
          child: Text("/发现,并创造自己的灵感/",style: whiteZhTextStyle2,)
          ),
    ]);
  }
}
