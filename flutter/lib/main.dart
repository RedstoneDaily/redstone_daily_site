import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:redstone_daily_site/404_page.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/coming_soon_page.dart';
import 'package:redstone_daily_site/jsonobject/issues_list.dart';

import 'contentPage/content_page.dart';
import 'mainPage/main_page.dart';

void main() {
  runApp(MyApp());
}

class IssuesListProvider extends ChangeNotifier {
  IssuesList? _issuesList;

  IssuesList? get issuesList => _issuesList;

  Future<IssuesList> loadIssuesList() async {
    _issuesList = await _fetchData().then((data) => compute(parseIssuesList, data));
    notifyListeners();
    return issuesList!;
  }

  Future<String> _fetchData() async {
    const String apiHost = String.fromEnvironment('API_HOST', defaultValue: '');
    Uri uri = apiHost != '' ? Uri.https(apiHost, '/api/list') : Uri.parse('/api/list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load the newspaper content. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
      rethrow;
    }
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      ///
      /// 主页
      ///
      GoRoute(
        path: '/',
        builder: (context, state) => const MainPage(),
      ),

      ///
      /// 内容页-日报
      /// params: year, month, day
      ///
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

      /// 最新日报
      GoRoute(
        path: '/daily',
        redirect: (context, state) async {
          IssuesListProvider issuesListProvider = Provider.of<IssuesListProvider>(context, listen: false);
          await issuesListProvider.loadIssuesList();
          return '/daily/${DateFormat("yyyy/MM/dd").format(issuesListProvider.issuesList!.dailyLatest().key)}';
        },
      ),

      ///
      /// 随机页面 （目前是随机日报）
      ///
      GoRoute(
          path: "/random",
          redirect: (context, state) {
            var list = Provider.of<IssuesListProvider>(context, listen: false).issuesList!.dailyFlattened();
            return '/daily/${DateFormat("yyyy/MM/dd").format(list[Random().nextInt(list.length)].key)}';
          }),

      ///
      /// 404 页面
      ///
      GoRoute(
        path: '/404/:random',
        builder: (context, state) => Status404Page(key: Key(state.pathParameters['random']!)),
      ),
      GoRoute(
        path: '/404',
        redirect: (_, state) => '/404/${Random().nextInt(100000)}',
      ),

      ///
      /// 待开发页面
      ///
      GoRoute(
        path: '/coming-soon',
        builder: (context, state) => const ComingSoonPage(), // 在路由中包含 ComingSoonPage
      ),
    ],
    errorBuilder: (context, state) => Status404Page(key: Key(state.error.toString())),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => IssuesListProvider()),
        ],
        child: MaterialApp.router(
          title: '红石日报',
          theme: ThemeData(
            colorScheme: RDColors.white,
            useMaterial3: true,
            fontFamily: 'FontquanXinYiGuanHeiTi',
            fontFamilyFallback: const ['Noto Sans SC'],
          ),
          routerConfig: _router,
        ));
  }
}
