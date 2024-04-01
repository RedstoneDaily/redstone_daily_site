import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/contentPage/foot_widget.dart';
import 'package:redstone_daily_site/contentPage/head_widget.dart';

import 'mainPage/main_page.dart';
import 'media_type.dart';
import 'contentPage/content_list.dart';
import 'contentPage/content_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '红石日报',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF740000),
                secondary: const Color(0xFF740000),
            ), useMaterial3: true, fontFamily: 'HuXiaoBo'),
        home: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverList(delegate: SliverChildListDelegate([
               MainPage()]))
          ],
        ));
  }
}
