import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:redstone_daily_site/404_page.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/jsonobject/issues_list.dart';
import 'package:http/http.dart' as http;

import 'mainPage/main_page.dart';
import 'contentPage/content_page.dart';

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
    const String apiHost = String.fromEnvironment('API_HOST', defaultValue: 'localhost');
    Uri uri = Uri.https(apiHost, '/api/list');
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => IssuesListProvider()),
        ],
        child: MaterialApp.router(
          title: '红石日报',
          theme: ThemeData(colorScheme: RDColors.white, useMaterial3: true, fontFamily: 'FontquanXinYiGuanHeiTi'),
          routerConfig: _router,
        ));
  }
}
