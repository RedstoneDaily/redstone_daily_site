import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redstone_daily_site/jsonobject/IssuesList.dart';

// onTap: () => showDialog(context: context, builder: chooserDialogBuilderBuilder(RDColors.glass)),
Future showChooserDialog({required BuildContext context, required ColorScheme colors}) {
  return showDialog(
      context: context,
      barrierColor: const Color(0x45000000),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Dialog(
              shape: const RoundedRectangleBorder(), // actually not rounded at all
              // shadowColor: const Color(0x22FFFFFF),
              backgroundColor: colors.surface,
              surfaceTintColor: const Color(0x00000000), // sb
              child: Theme(
                data: ThemeData(
                  colorScheme: colors,
                ),
                child: SizedBox(
                  width: 500,
                  height: 400,
                  child: ChooserDialogContent(
                    colors: colors,
                  ),
                ),
              )),
        );
      });
}

class ChooserDialogContent extends StatelessWidget {
  ChooserDialogContent({super.key, required this.colors});

  final ColorScheme colors;
  final Future<IssuesList> future = Future.value(IssuesList.fromJsonObject([
    "2024-04-01",
    "2024-04-04",
    "2024-04-23",
    "2024-04-18",
    "2024-04-08",
    "2024-04-03",
    "2024-04-14",
    "2024-04-15",
  ]));

  @override
  Widget build(BuildContext context) {
    builder(BuildContext context, AsyncSnapshot<IssuesList> snapshot) {
      IssuesList issuesList = snapshot.data!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 1,
              child: Center(
                child: Text("选择往期日报",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 20,
                    )),
              )),
          Flexible(
            flex: 4,
            child: CalendarDatePicker(
              initialDate: issuesList.daily.last,
              firstDate: DateTime(2024, 1, 1),
              lastDate: DateTime.now(),
              onDateChanged: (DateTime date) {},
              initialCalendarMode: DatePickerMode.day,
              selectableDayPredicate: (DateTime date) => issuesList.daily.contains(date),
            ),
          )
        ],
      );
    }

    return FutureBuilder(future: future, builder: builder);
  }
}

class MyFuckingBrilliantIssuePicker extends StatefulWidget {
  const MyFuckingBrilliantIssuePicker({super.key, required this.issuesList});

  final IssuesList issuesList;

  @override
  State<MyFuckingBrilliantIssuePicker> createState() => _MyFuckingBrilliantIssuePickerState();
}

class _MyFuckingBrilliantIssuePickerState extends State<MyFuckingBrilliantIssuePicker> {

  IssueTypes issueTypes = IssueTypes.daily;

  @override
  Widget build(BuildContext context) {
    const typeSelectorTextStyle = TextStyle(fontSize: 20);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [

        // First, a selector for types: daily, weekly, monthly, annual
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Text("选择往期", style: typeSelectorTextStyle),
              TextButton(
                onPressed: () {
                  setState(() {
                    issueTypes = IssueTypes.daily;
                  });
                },
                child: Text("日报", style: typeSelectorTextStyle),
              ),
            ],
          ),
        ),

        // Second, a navigation bar
        // daily: "yyyy / MM" with nav arrows
        // weekly: "yyyy" with nav arrows
        // monthly: "yyyy" with nav arrows
        // annual: no navigation bar
      ],
    );
  }
}

enum IssueTypes {
  daily,
  weekly,
  monthly,
  annual,
}
