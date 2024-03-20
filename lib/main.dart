import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:redstone_daily_site/contentwidget.dart';
import 'package:redstone_daily_site/headwidget.dart';
import 'package:redstone_daily_site/tiptest.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
          fontFamily: 'HuXiaoBo'),
      home: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(delegate: new SliverChildListDelegate(
            [
              MyHomePage(title: "title")
            ]
          ))
        ],
      )
    );
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
    return Material(
      child: Column(
        children: [
          HeadWidget(),
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Column(
              children: [
                Center(
                  child: ContentWidget(
                      "LOL", "sadasdasdaasdsadsadsdsad\ndasads\nasddas", 1),
                ),
                Container(
                  width: 400,
                  height: 150,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: [
                      ContentWidget("titlasdasdsadsdasade", "asdasdsadasdsad\nasdasdasdasdasdasd\ndasasda", 1),
                      ContentWidget("titlasdasdsadsdasade", "asdasdsadasdsad\nasdasdasdasdasdasd\ndasasda", 1),
                    ],
                  ),
                ),
                Container(
                  width: 400,
                  height: 600,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: [
                      ContentWidget("titlasdasdsadsdasade", "asdasdsadasdsad\nasdasdasdasdasdasd\ndasasda", 1),
                      ContentWidget("titlasdasdsadsdasade", "asdasdsadasdsad\nasdasdasdasdasdasd\ndasasda", 1),
                      ContentWidget("titlasdasdsadsdasade", "asdasdsadasdsad\nasdasdasdasdasdasd\ndasasda", 1),
                      ContentWidget("titlasdasdsadsdasade", "asdasdsadasdsad\nasdasdasdasdasdasd\ndasasda", 1),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
