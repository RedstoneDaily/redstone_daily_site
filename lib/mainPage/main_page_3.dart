import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexcolor/hexcolor_web.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/mainPage/parallelogram_button.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';

import '../media_type.dart';
import '../contentPage/typography.dart';
import 'typography.dart';
import 'nav_bar.dart';
import 'nav_button.dart';

class MainPage3 extends StatelessWidget {
  const MainPage3({super.key});

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
          children: [
            CustomPaint(
              painter: TrapezoidPainter(
                axis: Axis.horizontal,
                topStart: 0.36,
                topEnd: 1,
                bottomStart: 0.172,
                bottomEnd: 1,
                color: RDColors.scarlet.surface,
              ),
              size: Size(width, height),
            ),
            Positioned(
                top: height * 0.5,
                left: width * (0.36 + 0.172) / 2,
                child: FractionalTranslation(
                    translation: const Offset(-0.57, -0.475),
                    child: SizedBox.square(
                        dimension: 0.7 * height,
                        child: Image.asset(
                          "assets/images/mojang_banner_pattern.png",
                          filterQuality: FilterQuality.none,
                          fit: BoxFit.cover,
                        )))),
            Positioned(
                top: height * 0.207,
                left: width * 0.456,
                child: Text(
                  "查看我们的成果...",
                  textAlign: TextAlign.end,
                  style: textStyles.zhHeroText.copyWith(color: RDColors.scarlet.onSurface),
                )),
            Positioned(
                top: height * 0.502,
                left: width * 0.4,
                child: ParallelogramButton(
                  width: 0.397 * width,
                  height: 0.115 * height,
                  text: "查阅最新日报<<",
                  textStyle: textStyles.zhButton.copyWith(color: RDColors.white.onBackground),
                  buttonColor: RDColors.scarlet.onSurface,
                  callback: () => context.go("/daily"),
                )),
            Positioned(
                top: height * 0.686,
                left: width * 0.545,
                child: ParallelogramButton(
                  width: 0.397 * width,
                  height: 0.115 * height,
                  text: "或者看看往期...",
                  textStyle: textStyles.zhButton.copyWith(color: RDColors.white.onBackground),
                  buttonColor: RDColors.scarlet.onSurface,
                  callback: () {
                    // TODO 往期
                    context.go("/404");
                  },
                )),

            // Debug Reference Image
            // Positioned(
            //     top: 0,
            //     left: 0,
            //     child: Opacity(
            //         opacity: 0.3,
            //         child: Image.asset(
            //           "assets/test-ref-images/mainPage/3.png",
            //           width: size.width,
            //           fit: BoxFit.cover,
            //         )))
          ],
        ));
  }
}