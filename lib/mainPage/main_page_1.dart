import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/mainPage/parallelogram_button.dart';
import 'package:redstone_daily_site/mainPage/typography.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';

class MainPage1 extends StatelessWidget {
  const MainPage1({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textStyles = MainPageTypography(pageHeight: size.height);
    var width = size.width;
    var height = size.height;
    return Material(
        child: Container(
      width: width,
      height: height,
      color: RDColors.white.background,
      child: Stack(children: [
        // 背景Sureface
        CustomPaint(
          painter: TrapezoidPainter(
            axis: Axis.horizontal,
            topEnd: 0.215,
            bottomEnd: 0.4,
            color: RDColors.scarlet.surface,
          ),
          size: size,
        ),
        // 时钟
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
        // 标题 Hero-text
        Positioned(
            top: height * 0.075,
            left: width * 0.411,
            child: Text(
              "第一时间...",
              style: textStyles.zhHeroText.copyWith(color: RDColors.white.onBackground),
            )),
        Positioned(
            top: height * 0.245,
            left: width * 0.462,
            child: Text(
              "获得第一手信息。",
              style: textStyles.zhHeroText.copyWith(color: RDColors.white.onBackground),
            )),
        Positioned(
            top: height * 0.495,
            left: width * 0.451,
            child: Text(
              "我们每日都会排查并分析对你有帮助的\n红石视频,以便您研究时查看最新进展。",
              style: textStyles.zhTeaser.copyWith(color: RDColors.white.onBackground),
              maxLines: 2,
            )),
        Positioned(
            top: height * 0.783,
            left: width * 0.544,
            child: ParallelogramButton(
              width: 0.397 * width,
              height: 0.115 * height,
              text: ">>了解更多",
              textStyle: textStyles.zhButton.copyWith(color: RDColors.scarlet.onSurface),
              buttonColor: RDColors.scarlet.surface,
              onTap: () {
                // TODO: 了解更多
                context.go("/articles/more-info.md");
              },
            )),

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
    ));
  }
}
