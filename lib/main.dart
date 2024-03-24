import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/content_widget.dart';
import 'package:redstone_daily_site/head_widget.dart';
import 'package:redstone_daily_site/trapezoid_painter.dart';

import 'content_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF740000),
                secondary: const Color(0xFF740000),
            ), useMaterial3: true, fontFamily: 'HuXiaoBo'),
        home: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverList(delegate: SliverChildListDelegate([const MyHomePage(title: "title")]))
          ],
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var size = MediaQuery.of(context).size;

    var footerTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSecondary,
      fontSize: 20,
      letterSpacing: 3
    );

    return Stack(
      children: <Widget>[
        Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeadWidget(),
              ContentList(),
              // 底部
              Container(
                height: 100, // 设置容器的高度
                color: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '这里的第一行是各种声明,比如:本报所有内容均由用户生成,本报只做收集与整理,所有内容均与本报无关,就像这样,位占位占位占位占位占',
                      style: footerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '下面一行可以放一些鸣谢声明,像:本报版面由creepebucket设计,占位占位占位占位位占位占位占位占位占位占位占位占位占位占位占位',
                      style: footerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '在这里放一些东西,就像: 备案号:X公网安备XXX 支持我们:www.afdian.net/XXX 开源链接:github.com/XXX',
                      style: footerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),



        // A reference picture aligning to the top, resized to fit the width, 30% opacity
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   child: Opacity(
        //     opacity: 0.0,
        //     child: Image.asset(
        //       'assets/images/test_ref.png',
        //       width: size.width,
        //       fit: BoxFit.cover,
        //     )
        //   )
        // )
      ],
    );
  }
}
