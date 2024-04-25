// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:hexcolor/hexcolor_web.dart';
// import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
// import 'package:redstone_daily_site/mainPage/parallelogram_button.dart';
// import 'package:redstone_daily_site/mainPage/typography.dart';
// import 'package:redstone_daily_site/painter/line_painter.dart';
// import 'package:redstone_daily_site/painter/trapezoid_painter.dart';
//
// import '../media_type.dart';
// import '../text_styles.dart';
// import 'nav_bar.dart';
// import 'nav_button.dart';
//
// class MainContentPageEnd extends StatelessWidget {
//   const MainContentPageEnd({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     double height1 = 174;
//     var txt_height2 = height1 *
//         MediaType.large.width /
//         MediaType.medium.width; // sbDart 这个地方不能const
//     var txt_height = switch (getMediaType(context)) {
//       MediaType.small => size.width / MediaType.medium.width * height1,
//       MediaType.medium => size.width / MediaType.medium.width * height1,
//       MediaType.large => txt_height2,
//     };
//     var textStyles = MainPageTypography(height: txt_height);
//     var width = size.width;
//     var height = size.height;
//     return Container(
//         width: width,
//         height: height,
//         color: Theme.of(context).colorScheme.surface,
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             CustomPaint(
//               painter: TrapezoidPainter(
//                   axis: Axis.horizontal,
//                   topStart: 0.2,
//                   topEnd: 1.05,
//                   bottomStart: 0,
//                   bottomEnd: 0.85,
//                   color: HexColor("#740000")),
//               size: Size(width, height),
//             ),
//             Positioned(
//                 top: height * 0.15,
//                 left: width * 0.3,
//                 child: Text("除此之外...",
//                     textAlign: TextAlign.end,
//                     style: textStyles.zhTextStyle3)),
//             Positioned(
//                 top: height * 0.35,
//                 left: width * 0.4,
//                 child: Text("这里也有其它功能",
//                     textAlign: TextAlign.end,
//                     style: textStyles.zhTextStyle3)),
//             Positioned(
//                 bottom: height * -0.1,
//                 right: width * -0.02,
//                 child: Transform.rotate(
//                   angle: 30 * 3.14 / 180,
//                   child: SizedBox(
//                     width: 0.4 * width,
//                     height: 0.4 * width,
//                     child: Image.asset("assets/images/clock.png"),
//                   ),
//                 )),
//             Positioned(
//               top: height * 0.6,
//               left: width * 0.2,
//               child: ParallelogramButton(text:"<< 立刻探索",callback: (){},width: width, height: height, textStyles: textStyles),
//             ),
//           ],
//         ));
//   }
// }
