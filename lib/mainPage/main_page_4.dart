import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexcolor/hexcolor_web.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/mainPage/parallelogram_button.dart';
import 'package:redstone_daily_site/mainPage/typography.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';

import '../color_schemes.dart';
import '../media_type.dart';
import '../contentPage/typography.dart';
import 'nav_bar.dart';
import 'nav_button.dart';

class MainPage4 extends StatelessWidget {
  const MainPage4({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var txtHeight = size.height;
    var textStyles = MainPageTypography(pageHeight: txtHeight);
    var width = size.width;
    var height = size.height;
    return Container(
        width: width,
        height: height,
        color: RDColors.white.background,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              painter: TrapezoidPainter(
                axis: Axis.horizontal,
                topStart: 0.172,
                topEnd: 1.025,
                bottomStart: -0.016,
                // 0.172 - 0.188
                bottomEnd: 0.837,
                // 1.025 - 0.188
                color: RDColors.scarlet.surface,
              ),
              size: Size(width, height),
            ),
            Positioned(
                bottom: height * -0.195,
                right: width * -0.019,
                child: Transform.rotate(
                  angle: 21 * 3.14 / 180,
                  child: SizedBox.square(
                    dimension: 0.681 * height,
                    child: Image.asset(
                      "assets/images/recovery_compass_07.png",
                      filterQuality: FilterQuality.none,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Align(
                alignment: const FractionalOffset(0.35, 0.1),
                child: Text("除此之外...", textAlign: TextAlign.end, style: textStyles.zhHeroText.copyWith(color: RDColors.scarlet.onSurface))),
            Align(
                alignment: const FractionalOffset(0.743, 0.37),
                child: Text(
                  "这里也有其它功能",
                  textAlign: TextAlign.end,
                  style: textStyles.zhHeroText.copyWith(color: RDColors.scarlet.onSurface),
                )),
            Align(
                alignment: const FractionalOffset(0.24, 0.655),
                child: ParallelogramButton(
                  width: 0.397 * width,
                  height: 0.115 * height,
                  text: "<< 立刻探索   ",
                  textStyle: textStyles.zhButton.copyWith(color: RDColors.white.onBackground),
                  buttonColor: RDColors.scarlet.onSurface,
                  callback: () =>
                      // TODO 立刻探索????
                      context.go("/404"),
                )),

            // Debug Reference Image
            // Positioned(
            //     top: 0,
            //     left: 0,
            //     child: Opacity(
            //         opacity: 0.3,
            //         child: Image.asset(
            //           "assets/test-ref-images/mainPage/4.png",
            //           width: size.width,
            //           fit: BoxFit.cover,
            //         )))
          ],
        ));
  }
}