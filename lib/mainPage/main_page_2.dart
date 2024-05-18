import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/mainPage/parallelogram_button.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';

import 'typography.dart';

class MainPage2 extends StatelessWidget {
  const MainPage2({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var txtHeight = size.height;
    var textStyles = MainPageTypography(pageHeight: txtHeight);
    var width = size.width;
    var height = size.height;
    return Material(
        child: Container(
      width: width,
      height: height,
      color: RDColors.white.background,
      child: Stack(children: [
        // 背景
        CustomPaint(
          painter: TrapezoidPainter(
            axis: Axis.horizontal,
            topEnd: 0.605,
            bottomEnd: 0.791,
            color: RDColors.scarlet.surface,
          ),
          size: Size(width, height),
        ),
        Positioned(
            top: height * 0.5,
            left: width * (0.605 + 0.791) / 2,
            child: FractionalTranslation(
                translation: const Offset(-0.31, -0.55),
                child: Transform.rotate(
                    angle: -18 * 3.14159 / 180,
                    child: SizedBox(
                      width: 0.562 * height,
                      height: 0.562 * height,
                      child: Image.asset("assets/images/knowledge_book.png"),
                    )))),
        Positioned(
            top: height * 0.085,
            right: width * 0.427,
            child: Text(
              "励志打造全国最大的",
              textAlign: TextAlign.end,
              style: textStyles.zhHeroText.copyWith(color: RDColors.scarlet.onSurface),
              maxLines: 1,
            )),
        Positioned(
            top: height * 0.266,
            right: width * 0.434,
            child: Text(
              "红石信息库",
              textAlign: TextAlign.end,
              style: textStyles.zhHeroText.copyWith(color: RDColors.scarlet.onSurface),
              maxLines: 1,
            )),
        Positioned(
            top: height * 0.577,
            left: width * 0.065,
            child: ParallelogramButton(
              width: 0.397 * width,
              height: 0.115 * height,
              text: "即刻搜索<<",
              textStyle: textStyles.zhButton.copyWith(color: RDColors.white.onBackground),
              buttonColor: RDColors.scarlet.onSurface,
              onTap: () {
                // TODO: 跳转到搜索页面
                context.go("/coming-soon");
              },
            )),
        Positioned(
            top: height * 0.74,
            right: width * 0.3,
            child: Text(
              "通过每日的日报数据,长年累月即可形成\n庞大的数据库供查询。",
              textAlign: TextAlign.end,
              style: textStyles.zhButton.copyWith(color: RDColors.scarlet.onSurface),
              maxLines: 2,
            )),

        // Debug Reference Image
        // Positioned(
        //     top: 0,
        //     left: 0,
        //     child: Opacity(
        //         opacity: 0.3,
        //         child: Image.asset(
        //           "assets/test-ref-images/mainPage/2.png",
        //           width: size.width,
        //           fit: BoxFit.cover,
        //         )))
      ]),
    ));
  }
}
