import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/media_type.dart';
import 'package:redstone_daily_site/painter/trapezoid_painter.dart';

import '../selector_dialog.dart';
import 'typography.dart';

class HeadWidget extends StatefulWidget {
  const HeadWidget({super.key, required this.date});

  final routeHome = "/";
  final DateTime date;

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
      MediaType.small => size.width / MediaType.medium.width * height1,
      MediaType.medium => size.width / MediaType.medium.width * height1,
      MediaType.large => height2,
    };
    var typography = ContentPageTypography(height: height);

    const positionCoeffImage = (
      // Prevent code folding
      left: 0.0,
      top: -1.0,
      right: 0.0,
      bottom: -0.3
    );

    const cutFraction = 0.387;
    const inverseSlopeTrapezoid = 0.44;
    var isApprooooooaching = widget.date.month == 6 && widget.date.day == 15 && DateTime.timestamp().month == 6 && DateTime.timestamp().day == 15;

    return SizedBox(
      height: height,
      width: size.width,
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.topStart,
        clipBehavior: Clip.hardEdge,
        children: [
          // 背景图
          isApprooooooaching
              ? Positioned(
                  left: 0.3 * size.width,
                  top: 0 * height,
                  right: -0.2 * size.width,
                  bottom: 0 * height,
                  child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: ColorFiltered(
                          // lower the brightness
                          colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.multiply),
                          child: Image.asset(
                            'assets/images/backgrounds/approoooooaching.png',
                            fit: BoxFit.cover,
                          ))))
              : Positioned(
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
                            'assets/images/backgrounds/rd-nn.webp',
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
              color: RDColors.scarlet.surface,
            ),
            size: Size(size.width, height),
          ),
          Positioned.fill(
              child: Row(mainAxisSize: MainAxisSize.max, children: [
            Flexible(
                child: FractionallySizedBox(
                    widthFactor: cutFraction * 2.0, // Who can explain why it needs * 2.0?????
                    heightFactor: 1.0,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: leftTexts(height, typography),
                    ))),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: rightTexts(height, typography),
            )),
          ])),
          Positioned(
              bottom: 0.04 * height,
              right: 0.01 * height,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  // onTap: () => showDialog(context: context, builder: chooserDialogBuilderBuilder(RDColors.glass)),
                  onTap: () => showSelectorDialog(context: context, colors: RDColors.glass),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isApprooooooaching
                          ? Image.asset("assets/images/backgrounds/15 JUNE.jpg", height: 0.2 * height)
                          : Transform.scale(scaleY: 1.2, child: Text("[${DateFormat("yyyy-MM-dd").format(widget.date)}]", style: typography.issueNum)),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 36),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget leftTexts(double height, ContentPageTypography typography) {
    return SizedBox(
        width: 1.1 * height,
        height: height,
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () {
                  context.go(widget.routeHome);
                },
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                      right: 0.375 * height,
                      top: 0.054 * height,
                      child: Text("红", style: typography.mastheadZh1),
                    ),
                    Positioned(
                      right: 0.135 * height,
                      top: 0.13 * height,
                      child: Text("石", style: typography.mastheadZh1),
                    ),
                    Positioned(right: 0.272 * height, top: 0.5 * height, child: Text("Redstone", style: typography.mastheadEn1))
                  ],
                ))));
  }

  Widget rightTexts(double height, ContentPageTypography typography) {
    return SizedBox(
        width: height,
        height: 1.1 * height,
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () {
                  context.go(widget.routeHome);
                },
                child: Stack(fit: StackFit.loose, children: [
                  Positioned(
                    left: 0.46 * height,
                    top: 0.245 * height,
                    child: Text("Daily", style: typography.mastheadEn2),
                  ),
                  Positioned(
                    left: 0.08 * height,
                    top: 0.405 * height,
                    child: Text("日", style: typography.mastheadZh2),
                  ),
                  Positioned(
                    left: 0.34 * height,
                    top: 0.405 * height,
                    child: Text("报", style: typography.mastheadZh2),
                  )
                ]))));
  }
}
