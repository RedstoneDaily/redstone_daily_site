import 'package:flutter/material.dart';
import 'package:redstone_daily_site/mainPage/main_page_end.dart';

import 'main_page_0.dart';
import 'main_page_1.dart';
import 'main_page_2.dart';
import 'main_page_3.dart';
import 'main_page_4.dart';

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
              MainPage0(),
              MainPage1(),
              MainPage2(),
              MainPage3(),
              MainPage4(),
              MainPageEnd(),
            ],
          ),
        )]))
      ],
    );
  }
}
