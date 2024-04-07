import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexcolor/hexcolor_web.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/mainPage/rectangle_button.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';

import '../media_type.dart';
import '../text_styles.dart';
import 'nav_bar.dart';
import 'nav_button.dart';

class MainContentPage3 extends StatelessWidget {
  const MainContentPage3({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height1 = 174;
    var txt_height2 = height1 *
        MediaType.large.width /
        MediaType.medium.width; // sbDart 这个地方不能const
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
        child: Stack(
          children: [
            CustomPaint(
              painter: TrapezoidPainter(
                  axis: Axis.horizontal,
                  topStart: 0.6,
                  topEnd: 1,
                  bottomStart: 0.4,
                  bottomEnd: 1,
                  color: HexColor("#740000")),
              size: Size(width, height),
            ),
            Positioned(
                top: height * 0.25,
                left: width * 0.1,
                child: SizedBox(
                  width: 0.4 * width,
                  height: 0.4 * width,
                  child: Image.asset("assets/images/knowledge_book.png"),
                )),
            Positioned(
                top: height * 0.1,
                left: width * 0.6,
                child: Text("查看我们的成果",
                    textAlign: TextAlign.end,
                    style: textStyles.whiteZhTextStyle3)),
            Positioned(
              top: height * 0.6,
              left: width * 0.4,
              child: RectangleButton(text:"查阅最新日报<<",callback: (){},width: width, height: height, textStyles: textStyles),
            ),
            Positioned(
              top: height * 0.7,
              left: width * 0.55,
              child: RectangleButton(text:"或者看看往期...",callback: (){},width: width, height: height, textStyles: textStyles),
            ),
          ],
        ));
  }
}
