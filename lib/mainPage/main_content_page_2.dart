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

class MainContentPage2 extends StatelessWidget {
  const MainContentPage2({
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
              topEnd: 0.6,
              bottomEnd: 0.8,
              color: HexColor("#740000")),
          size: Size(width, height),
        ),
        Positioned(
            top: height * 0.25,
            left: width * 0.5,
            child: SizedBox(
              width: 0.4 * width,
              height: 0.4 * width,
              child: Image.asset("assets/images/knowledge_book.png"),
            )),
        Positioned(
            top: height * 0.1,
            left: width * 0.1,
            child: Text("励志打造全国最大的\n红石信息库",textAlign: TextAlign.end,style: textStyles.whiteZhTextStyle3, maxLines: 2)),
        Positioned(
            top: height * 0.7,
            left: width * 0.2,
            child: InkWell(
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
                    Align(child: Text("立即搜索<<",style: textStyles.blackZhTextStyle2,))
                  ],
                ),
              ),
            )),
        Positioned(
            top: height * 0.9,
            left: width * 0.2,
            child: Text("通过每日的日报数据,长年累月即可形成\n庞大的数据库供查询。",textAlign: TextAlign.end,style: textStyles.whiteZhTextStyle4, maxLines: 2)),

      ]),
    );
  }
}
