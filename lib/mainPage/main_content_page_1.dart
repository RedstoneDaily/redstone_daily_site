import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexcolor/hexcolor_web.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/mainPage/parallelogram_button.dart';
import 'package:redstone_daily_site/mainPage/typography.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';

import '../media_type.dart';
import '../contentPage/typography.dart';
import 'nav_bar.dart';
import 'nav_button.dart';

class MainContentPage1 extends StatelessWidget {
  const MainContentPage1({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var txtHeight = size.height;
    var textStyles = MainPageTypography(height: txtHeight);
    var width = size.width;
    var height = size.height;
    return Container(
      width: width,
      height: height,
      color: RDColorSchemes.white.background,
      child: Stack(children: [
        CustomPaint(
          painter: TrapezoidPainter(
            axis: Axis.horizontal,
            topEnd: 0.215,
            bottomEnd: 0.4,
            color: RDColorSchemes.scarlet.surface,
          ),
          size: Size(width, height),
        ),
        Positioned(
            top: height * 0.5,
            left: width * (0.215 + 0.4) / 2,
            child: FractionalTranslation(
                translation: const Offset(-0.76, -0.445),
                child: Transform.rotate(
                  angle: -19 * 3.14159 / 180,
                  child: SizedBox(
                    width: 0.562 * height,
                    height: 0.562 * height,
                    child: Image.asset("assets/images/clock.png"),
                  ),
                ))),
        Positioned(
            top: height * 0.075,
            left: width * 0.411,
            child: Text(
              "第一时间...",
              style: textStyles.zhTextStyle1.copyWith(color: RDColorSchemes.white.onBackground),
            )),
        Positioned(
            top: height * 0.245,
            left: width * 0.462,
            child: Text(
              "获得第一手信息。",
              style: textStyles.zhTextStyle1.copyWith(color: RDColorSchemes.white.onBackground),
            )),
        Positioned(
            top: height * 0.495,
            left: width * 0.451,
            child: Text(
              "我们每日都会排查并分析对你有帮助的\n红石视频,以便您研究时查看最新进展。",
              style: textStyles.zhTextStyle2.copyWith(color: RDColorSchemes.white.onBackground),
              maxLines: 2,
            )),
        Positioned(
            top: height * 0.783,
            left: width * 0.544,
            child: ParallelogramButton(
              width: 0.397 * width,
              height: 0.115 * height,
              text: ">>了解更多",
              textStyle: textStyles.zhTextStyle3.copyWith(color: RDColorSchemes.scarlet.onSurface),
              buttonColor: RDColorSchemes.scarlet.surface,
              callback: () {
                print("clicked");
              },
            )
        ),

        // Debug Reference Image
        // Positioned(
        //     top: 0,
        //     left: 0,
        //     child: Opacity(
        //         opacity: 0.3,
        //         child: Image.asset(
        //           "assets/test-ref-images/mainPage/1.png",
        //           width: size.width,
        //           fit: BoxFit.cover,
        //         )))
      ]),
    );
  }
}
