import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:redstone_daily_site/contentPage/foot_widget.dart';
import 'package:redstone_daily_site/contentPage/head_widget.dart';
import 'package:redstone_daily_site/color_schemes.dart';

import 'mainPage/main_page.dart';
import 'media_type.dart';
import 'contentPage/content_list.dart';
import 'contentPage/content_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/daily',
        builder: (context, state) => const ContentPage(),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: '红石日报',
        theme: ThemeData(
            colorScheme: RDColors.white,
            useMaterial3: true,
            fontFamily: 'FontquanXinYiGuanHeiTi'
        ),
        routerConfig: _router,
    );
  }
}
