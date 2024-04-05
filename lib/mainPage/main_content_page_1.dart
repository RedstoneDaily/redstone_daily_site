import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexcolor/hexcolor_web.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';

import '../media_type.dart';
import '../text_styles.dart';
import 'nav_bar.dart';
import 'nav_button.dart';

class MainContentPage1 extends StatelessWidget {
  const MainContentPage1({
    super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height1 = 174;
    var txt_height2 = height1 * MediaType.large.width / MediaType.medium.width; // sbDart 这个地方不能const
    var txt_height = switch (getMediaType(context)) {
      MediaType.small => size.width / MediaType.medium.width * height1,
      MediaType.medium => size.width / MediaType.medium.width * height1,
      MediaType.large => txt_height2,
    };
    var textStyles = TextStyles(height: txt_height);
    var width = size.width;
    var height = size.height;
    return Container(
      width: width,
      height: height,
      color: Colors.black26,
      child: Stack(children: [
        CustomPaint(
          painter: TrapezoidPainter(
              axis: Axis.horizontal,
              topEnd: 0.3,
              bottomEnd: 0.5,
              color: HexColor("#740000")),
          size: Size(width, height),
        ),
        Positioned(
            top: height * 0.25,
            left: width * 0.07,
            child: Transform.rotate(
              angle: -30 * 3.14 / 180,
              child: SizedBox(
                width: 0.4 * width,
                height: 0.4 * width,
                child: Image.asset("assets/images/clock.png"),
              ),
            )),
        Positioned(
            top: height * 0.1, left: width * 0.5, child: Text("第一时间...",style: textStyles.blackZhTextStyle1)),
        Positioned(
            top: height * 0.25, left: width * 0.57, child: Text("得到第一手信息...",style: textStyles.blackZhTextStyle1)),
        Positioned(
            top: height * 0.45,
            left: width * 0.55,
            child: Text("我们每日都会排查并分析对你有帮助的\n红石视频,以便您研究时查看最新进展。",style: textStyles.blackZhTextStyle2, maxLines: 2)),
        Positioned(
            top: height * 0.7,
            left: width * 0.6,
            child: InkWell(
              child: Container(
                width: 0.35 * width,
                height: 0.15 * height,
                child: Stack(
                  children: [
                    CustomPaint(
                        painter: TrapezoidPainter(
                            color: HexColor("#740000"),
                            topStart: 0.2,
                            topEnd: 1,
                            bottomStart: 0,
                            bottomEnd: 0.8),
                        size: Size(0.35 * width, 0.15 * height)),
                    Align(child: Text(">>了解更多",style: textStyles.whiteZhTextStyle3,))
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}
