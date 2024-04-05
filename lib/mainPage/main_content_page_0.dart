import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';

import '../media_type.dart';
import '../text_styles.dart';
import 'nav_bar.dart';
import 'nav_button.dart';
class MainContentPage0 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height1 = 174;
    var height2 = height1 * MediaType.large.width / MediaType.medium.width; // sbDart 这个地方不能const
    var height = switch (getMediaType(context)) {
      MediaType.small => size.width / MediaType.medium.width * height1,
      MediaType.medium => size.width / MediaType.medium.width * height1,
      MediaType.large => height2,
    };
    var textStyle = TextStyles(height: height);

    return Stack(children: [
      Image.asset("assets/images/main_1.png"),
      NavBar(),
      Positioned(
          top: height * 0.3,
          left: height * 0.2,
          child: Text(
            "红石",
            style: textStyle.redZhTextStyle1,
          )),
      Transform.translate(offset: Offset(height*0.1,height*0.1),child:  CustomPaint(
            painter: LinePainter(Colors.red, Offset(height * 0.5, height * 1.1),
                Offset(height * 1.1, height * 0.4), 2)),
      ),
      Transform.translate(
        offset: Offset(height*0.2,height * 0.2),
        child: CustomPaint(
            painter: LinePainter(
                Colors.white,
                Offset(height * 0.5, height * 1.1),
                Offset(height * 1.1, height * 0.4),
                2)),
      ),
      Positioned(
          top: height * 0.8,
          left: height * 1.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "日报",
                style: textStyle.whiteZhTextStyle1,
              ),
              DateTextWidget(textStyle.whiteZhTextStyle2),
            ],
          )),
      Positioned(
          top: height * 1.5,
          left: height * 0.2,
          child: Text("/发现,并创造自己的灵感/",style: textStyle.whiteZhTextStyle2,)
          ),
    ]);
  }
}
