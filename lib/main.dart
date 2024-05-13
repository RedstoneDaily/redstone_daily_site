import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redstone_daily_site/404_page.dart';
import 'package:redstone_daily_site/color_schemes.dart';

import 'mainPage/main_page.dart';
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
        path: '/daily/:year/:month/:day',
        builder: (context, state) {
          final year = state.pathParameters['year']!;
          final month = state.pathParameters['month']!;
          final day = state.pathParameters['day']!;
          // ... logic to fetch and display newspaper for the specified date
          return ContentPage(date: DateTime(int.parse(year), int.parse(month), int.parse(day))); // Pass date to ContentPage
        },
      ),
      GoRoute(
        path: '/daily',
        redirect: (_, state) {
          final now = DateTime.now();
          final year = now.year.toString();
          final month = now.month.toString().padLeft(2, '0');
          final day = now.day.toString().padLeft(2, '0');
          return '/daily/$year/$month/$day';
        },
      ),
      GoRoute(
        path: '/404/:random',
        builder: (context, state) => Status404Page(key: Key(state.pathParameters['random']!)),
      ),
      GoRoute(
        path: '/404',
        redirect: (_, state) => '/404/${Random().nextInt(100000)}',
      ),
    ],
    errorBuilder: (context, state) => Status404Page(key: Key(state.error.toString())),
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
