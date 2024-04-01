import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';

import '../media_type.dart';
import 'my_nav_bar.dart';
import 'my_nav_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height1 = 174;
    var height2 = height1 *
        MediaType.large.width /
        MediaType.medium.width; // sbDart 这个地方不能const
    var height = switch (getMediaType(context)) {
      MediaType.small => size.width / MediaType.medium.width * height1,
      MediaType.medium => size.width / MediaType.medium.width * height1,
      MediaType.large => height2,
    };
    var redZhTextStyle1 = TextStyle(
      color: Colors.red,
      fontSize: 0.4 * height,
    );
    var whiteZhTextStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 0.4 * height,
    );
    return Material(
      child: Stack(children: [
        Image.asset("assets/images/main_1.png"),
        MyNavBar(),
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
            child: Text(
              "日报",
              style: whiteZhTextStyle1,
            )),
      ]),
    );
  }
}
