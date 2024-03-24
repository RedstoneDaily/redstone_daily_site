import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/trapezoid_painter.dart';

class HeadWidget extends StatefulWidget {
  const HeadWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HeadState();
  }
}

enum SizeCategory {
  small,
  medium,
  large,
}

class _HeadState extends State<HeadWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const modelSize1 = Size(1080, 175);
    const modelSize2 = Size(1920, 1920 / 1080 * 175);
    var sizeCategory = size.width < modelSize1.width
        ? SizeCategory.small
        : size.width < modelSize2.width
            ? SizeCategory.medium
            : SizeCategory.large;
    var height = switch(sizeCategory){
      SizeCategory.small => modelSize1.height,
      SizeCategory.medium => size.width / modelSize1.width * modelSize1.height,
      SizeCategory.large => modelSize2.height,
    };

    const positionCoeffImage = (
      // Prevent code folding
      left: 0.0,
      top: -1.0,
      right: 0.0,
      bottom: -0.3
    );

    const cutFraction = 0.387;
    const inverseSlopeTrapezoid = 0.44;

    var whiteZhTextStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 0.31 * height,
      // fontWeight: FontWeight.w500,
    );

    var whiteZhTextStyle2 = TextStyle(
      color: Colors.white,
      fontSize: 0.35 * height,
      // fontWeight: FontWeight.w500,
    );

    var whiteEnTextStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 0.155 * height,
      // fontWeight: FontWeight.w500,
    );

    var whiteEnTextStyle2 = TextStyle(
      color: Colors.white,
      fontSize: 0.155 * height,
      letterSpacing: 3,
      // fontWeight: FontWeight.w500,
    );

    return SizedBox(
      height: height,
      width: size.width,
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.topStart,
        clipBehavior: Clip.hardEdge,
        children: [
          // 背景图
          Positioned(
              left: positionCoeffImage.left * size.width,
              top: positionCoeffImage.top * height,
              right: positionCoeffImage.right * size.width,
              bottom: positionCoeffImage.bottom * height,
              child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: ColorFiltered(
                      // lower the brightness
                      colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.multiply),
                      child: Image.asset(
                        'assets/images/header-background.png',
                        fit: BoxFit.cover,
                      )))),
          // 梯形
          CustomPaint(
            painter: TrapezoidPainter(
                axis: Axis.horizontal,
                topStart: 0,
                bottomStart: 0,
                topEnd: cutFraction + 0.5 * height * inverseSlopeTrapezoid / size.width,
                bottomEnd: cutFraction - 0.5 * height * inverseSlopeTrapezoid / size.width,
                color: const Color(0xFF740000)),
            size: Size(size.width, height),
          ),
          SizedBox(
              width: size.width,
              height: height,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                      child: FractionallySizedBox(
                          widthFactor: cutFraction * 2.0, // Who can explain why it needs * 2.0?????
                          heightFactor: 1.0,
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Positioned(
                                right: 0.375 * height,
                                top: 0.054 * height,
                                child: Text(
                                  "红",
                                  style: whiteZhTextStyle1,
                                ),
                              ),
                              Positioned(
                                right: 0.135 * height,
                                top: 0.13 * height,
                                child: Text(
                                  "石",
                                  style: whiteZhTextStyle1,
                                ),
                              ),
                              Positioned(
                                right: 0.272 * height,
                                top: 0.5 * height,
                                child: Text("Redstone", style: whiteEnTextStyle1),
                              )
                            ],
                          ))),
                  Expanded(
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Positioned(
                          left: 0.46 * height,
                          top: 0.245 * height,
                          child: Text("Daily", style: whiteEnTextStyle2),
                        ),
                        Positioned(
                          left: 0.08 * height,
                          top: 0.405 * height,
                          child: Text("日", style: whiteZhTextStyle2),
                        ),
                        Positioned(
                          left: 0.34 * height,
                          top: 0.405 * height,
                          child: Text("报", style: whiteZhTextStyle2),
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
