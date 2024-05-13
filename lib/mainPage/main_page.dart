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
        SliverList(delegate: SliverChildListDelegate([Material(
          child: Column(
            children: [
              const MainPage0(),
              const MainPage1(),
              const MainPage2(),
              const MainPage3(),
              const MainPage4(),
              MainPageEnd(),
            ],
          ),
        )]))
      ],
    );
  }
}
