import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'content_list.dart';
import 'foot_widget.dart';
import 'head_widget.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key, required this.date});

  ContentPage.fromStr({super.key, required yearStr, required monthStr, required dayStr})
      : date = DateTime.utc(int.parse(yearStr), int.parse(monthStr), int.parse(dayStr));

  final DateTime date;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(child: HeadWidget(date: widget.date)),
          SilverContentList(date: widget.date, key: Key("daily ${DateFormat("yyyy-MM-dd").format(widget.date)}")),
          const SliverToBoxAdapter(child: FootWidget()),
        ],
      ),
    );
  }
}
