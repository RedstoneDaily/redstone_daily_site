import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redstone_daily_site/mainPage/main_page_end.dart';
import 'package:redstone_daily_site/utils/dyn_mouse_scroll_for_page.dart';

import '../main.dart';
import 'main_page_0.dart';
import 'main_page_1.dart';
import 'main_page_2.dart';
import 'main_page_3.dart';
import 'main_page_4.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<IssuesListProvider>(context, listen: false).loadIssuesList();
  }

  @override
  Widget build(BuildContext context) {
    return DynMouseScrollForPage(
      builder: (BuildContext context, PageController controller, ScrollPhysics physics) => PageView(
        scrollDirection: Axis.vertical,
        controller: controller,
        physics: physics,
        // pageSnapping: false,
        children: [
          const MainPage0(),
          const MainPage1(),
          const MainPage2(),
          const MainPage3(),
          const MainPage4(),
          MainPageEnd(),
        ],
      ),
    );
  }
}
