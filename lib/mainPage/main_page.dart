import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redstone_daily_site/mainPage/date_text_widget.dart';
import 'package:redstone_daily_site/mainPage/main_content_page_end.dart';
import 'package:redstone_daily_site/painter/line_painter.dart';

import '../media_type.dart';
import 'main_content_page_0.dart';
import 'main_content_page_1.dart';
import 'main_content_page_2.dart';
import 'main_content_page_3.dart';
import 'main_content_page_4.dart';
import 'nav_bar.dart';
import 'nav_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverList(delegate: SliverChildListDelegate([const Material(
          child: Column(
            children: [
              MainContentPage0(),
              MainContentPage1(),
              MainContentPage2(),
              MainContentPage3(),
              MainContentPage4(),
              MainContentPageEnd(),
            ],
          ),
        )]))
      ],
    );
  }
}
