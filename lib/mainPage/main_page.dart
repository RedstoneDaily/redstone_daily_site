import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';

import '../media_type.dart';
import 'main_content_page_0.dart';
import 'main_content_page_1.dart';
import 'nav_bar.dart';
import 'nav_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height1 = 174;
    var height2 = height1 *
        MediaType.large.width /
        MediaType.medium.width; // sbDart 这个地方不能const
    var height = switch (getMediaType(context)) {
      MediaType.small => size.width / MediaType.medium.width * height1,
      MediaType.medium => size.width / MediaType.medium.width * height1,
      MediaType.large => height2,
    };
    var redZhTextStyle1 = TextStyle(
      color: Colors.red,
      fontSize: 0.4 * height,
    );
    var whiteZhTextStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 0.4 * height,
    );
    var whiteZhTextStyle2 = TextStyle(
      color: Colors.white,
      fontSize: 0.15 * height,
    );
    return Material(
      child: Column(
        children: [
          MainContentPage0(height: height, redZhTextStyle1: redZhTextStyle1, whiteZhTextStyle1: whiteZhTextStyle1, whiteZhTextStyle2: whiteZhTextStyle2),
          MainContentPage1(height: height, redZhTextStyle1: redZhTextStyle1, whiteZhTextStyle1: whiteZhTextStyle1, whiteZhTextStyle2: whiteZhTextStyle2),
        ],
      ),
    );
  }
}
