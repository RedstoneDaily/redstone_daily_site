import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/media_type.dart';
import 'package:redstone_daily_site/trapezoid_painter.dart';

class HeadWidget extends StatefulWidget {
  const HeadWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HeadState();
  }
}

class _HeadState extends State<HeadWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height1 = 174;
    var height2 = height1 * MediaType.large.width / MediaType.medium.width; // sbDart 这个地方不能const
    var height = switch (getMediaType(context)) {
      MediaType.small => height1,
      MediaType.medium => size.width / MediaType.medium.width * height1,
      MediaType.large => height2,
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
    );

    var whiteZhTextStyle2 = TextStyle(
      color: Colors.white,
      fontSize: 0.35 * height,
    );

    var whiteEnTextStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 0.155 * height,
    );

    var whiteEnTextStyle2 = TextStyle(
      color: Colors.white,
      fontSize: 0.155 * height,
      letterSpacing: 3,
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
              color: Theme.of(context).colorScheme.secondary,
            ),
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
