import 'package:flutter/material.dart';

import 'content_list.dart';
import 'foot_widget.dart';
import 'head_widget.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key, required this.year, required this.month, required this.day});

  final String year;
  final String month;
  final String day;

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
          const SliverToBoxAdapter(child: HeadWidget()),
          ContentList(year: widget.year, month: widget.month, day: widget.day),
          const SliverToBoxAdapter(child: FootWidget()),
        ],
      ),
    );
  }
}
