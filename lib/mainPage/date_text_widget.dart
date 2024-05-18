import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:redstone_daily_site/color_schemes.dart';
import 'package:redstone_daily_site/selector_dialog.dart';

import '../main.dart';

class DateTextWidget extends StatelessWidget {
  final TextStyle textStyle;

  const DateTextWidget(this.textStyle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IssuesListProvider>(builder: (context, issuesListProvider, child) {
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              // onTap: () => showDialog(context: context, builder: chooserDialogBuilderBuilder(RDColors.glass)),
              onTap: () => showSelectorDialog(context: context, colors: RDColors.glass),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  "[${DateFormat('y.M.d').format(issuesListProvider.issuesList?.dailyLatest().key ?? DateTime.now())}]",
                  style: textStyle,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 40),
                )
              ])));
    });
  }
}
